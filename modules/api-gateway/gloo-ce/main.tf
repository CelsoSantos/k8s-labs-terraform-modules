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

resource "helm_release" "gloo_ce" {
  name       = "gloo-ce"
  repository = "https://storage.googleapis.com/solo-public-helm"
  chart      = "gloo"
  version    = "${var.release_version}"
  namespace  = "${var.namespace}"
  atomic     = false

  values = [
    "${file("${path.module}/tmpl/values.yaml")}"
  ]

  # values = [
  #   "${templatefile("${path.module}/tmpl/values.tmpl", {
  #      discovery_enabled  = var.discovery_enabled
  #      discovery_fds_mode = var.discovery_fds_mode
  #      gateway_enabled    = var.gateway_enabled
  #      knative_enabled    = var.knative_enabled
  #      knative_version    = var.knative_version
  #   })}"
  # ]

  # set_sensitive {
  #   name  = "license_key"
  #   value = "${var.license_key}"
  # }

  depends_on = [
    kubernetes_namespace.gloo_system
  ]
}
