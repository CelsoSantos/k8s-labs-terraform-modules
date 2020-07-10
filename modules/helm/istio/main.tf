###############################################################################
# Description: Istio Terraform Module actions                                 #
###############################################################################

# Create namespace for istio
resource "kubernetes_namespace" "istio_system" {
  metadata {
    annotations = {
      name = "istio-system"
    }
    name = "istio-system"
  }
}

# Add istio repo
resource "null_resource" "helm_repo_istio" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/helm repo add istio.io https://storage.googleapis.com/istio-release/releases/${var.istio_release_chart_version}/charts/ && /usr/local/bin/helm repo update"
  }
}

# Install istio CRDs
resource "null_resource" "helm_install_istio_init" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/helm upgrade istio-init --atomic --install --version v${var.istio_release_chart_version} --namespace istio-system istio.io/istio-init"
  }
  depends_on = [
    null_resource.helm_repo_istio
  ]
}

# Wait for Istio CRDs completion
resource "null_resource" "helm_install_istio_init_wait" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/kubectl -n istio-system wait --for=condition=complete job --all"
  }
  depends_on = [
    null_resource.helm_install_istio_init
  ]
}

data "template_file" "helm_install_istio_values" {
  template = file("${path.module}/tmpl/values-istio-sds-auth.tmpl")

  vars = {
    ca_addr     = var.istio_ca_addr
    ca_provider = var.istio_ca_provider
    mtls        = var.istio_mtls_enabled
    nodeagent   = var.istio_nodeagent_enabled
    sds         = var.istio_sds_enabled
  }

  depends_on = [
    null_resource.helm_install_istio_init_wait
  ]
}

resource "local_file" "helm_install_istio_values" {
  content  = data.template_file.helm_install_istio_values.rendered
  filename = "${path.module}/tmpl/values-istio-sds-auth.yaml"
}

# Install istio with SDS and mTLS
resource "null_resource" "helm_install_istio" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/helm upgrade istio --atomic --install --version v${var.istio_release_chart_version} --namespace istio-system istio.io/istio --values ${path.module}/tmpl/values-istio-sds-auth.yaml"
  }
  depends_on = [
    local_file.helm_install_istio_values
  ]
}

