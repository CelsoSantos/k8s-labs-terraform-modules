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

resource "helm_release" "gloo_ee" {
  name       = "gloo-ee"
  repository = "http://storage.googleapis.com/gloo-ee-helm"
  chart      = "gloo-ee"
  version    = "${var.release_version}"brewfdf
  namespace  = "${var.namespace}"
  atomic     = false

  values = [
    "${templatefile("${path.module}/tmpl/values.tmpl", {
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
    })}"
  ]

  set_sensitive {
    name  = "license_key"
    value = "${var.license_key}"
  }

  depends_on = [
    kubernetes_namespace.gloo_system
  ]
}
