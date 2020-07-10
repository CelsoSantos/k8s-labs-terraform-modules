###############################################################################
# Description: Main for Gloo Gateway Terraform Module                         #
###############################################################################

resource "kubernetes_namespace" "gloo_system" {
  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace
  }
}

# Add the Solo Helm repository and update your local Helm chart repository cache
resource "null_resource" "helm_repo_gloo" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/helm repo add gloo https://storage.googleapis.com/solo-public-helm && /usr/local/bin/helm repo update"
  }
}

data "template_file" "gloo_ce_values_template" {
  template = file("${path.module}/tmpl/values.tmpl")

  vars = {
    discovery_enabled  = var.discovery_enabled
    discovery_fds_mode = var.discovery_fds_mode
    gateway_enabled    = var.gateway_enabled
    knative_enabled    = var.knative_enabled
    knative_version    = var.knative_version
  }

  depends_on = [
    null_resource.helm_repo_gloo
  ]
}

resource "local_file" "gloo_ce_values_render" {
  content  = data.template_file.gloo_ce_values_template.rendered
  filename = "${path.root}/generated/gloo-ce/values.yaml"
}

resource "null_resource" "gloo_gateway" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/helm install gloo gloo/gloo --atomic -f ${path.root}/generated/gloo-ce/values.yaml --namespace ${var.namespace}"
  }
  depends_on = [
    local_file.gloo_ce_values_render
  ]
}

