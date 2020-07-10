###############################################################################
# Description: Main for Gloo Enterprise Gateway Terraform Module              #
###############################################################################

resource "kubernetes_namespace" "gloo_system" {
  metadata {
    annotations = {
      name = var.namespace
    }
    name = var.namespace
  }
}

data "template_file" "gloo_ee_values_template" {
  template = file("${path.module}/tmpl/values.tmpl")

  vars = {
    access_logger_enabled = var.access_logger_enabled
    license_key           = var.license_key
    discovery_enabled     = var.discovery_enabled
    discovery_fds_mode    = var.discovery_fds_mode
    discovery_stats       = var.discovery_stats
    gateway_enabled       = var.gateway_enabled
    gateway_stats         = var.gateway_stats
    grafana_password      = var.grafana_password
    grafana_url           = var.grafana_url
    grafana_username      = var.grafana_username
    knative_enabled       = var.knative_enabled
    knative_version       = var.knative_version
    prometheus_url        = var.prometheus_url
    stats                 = var.stats
  }

  depends_on = [
    kubernetes_namespace.gloo_system
  ]
}

resource "local_file" "gloo_ee_values_render" {
  content  = data.template_file.gloo_ee_values_template.rendered
  filename = "${path.root}/generated/gloo-ee/values.yaml"
}

resource "helm_release" "gloo_ee" {
  name       = "gloo-ee"
  repository = "http://storage.googleapis.com/gloo-ee-helm"
  chart      = "gloo-ee"
  version    = "${var.release_version}"
  namespace  = "${var.namespace}"
  atomic     = true

  values = [
    "${file("${path.root}/generated/gloo-ee/values.yaml")}"
  ]

  set_sensitive {
    name  = "license_key"
    value = "${var.license_key}"
  }

  depends_on = [
    local_file.gloo_ee_values_render
  ]
}

# resource "null_resource" "gloo_gateway" {
#   provisioner "local-exec" {
#     # environment = {
#     #   KUBECONFIG = "${path.root}/creds/config"
#     # }
#     command = "/usr/local/bin/helm install gloo-ee ${path.module}/gloo-ee/ --atomic -f ${path.root}/generated/gloo-ee/values.yaml --namespace ${var.namespace} --set-string license_key=${var.license_key}"
#   }
#   depends_on = [
#     local_file.gloo_ee_values_render
#   ]
# }

