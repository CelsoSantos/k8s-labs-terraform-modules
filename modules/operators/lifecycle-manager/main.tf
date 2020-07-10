###############################################################################
# Description: Main for Operator Lifecycle Manager Terraform Module           #
###############################################################################

# Create the namespace for Operator Lifecycle Manager
resource "kubernetes_namespace" "operator_lifecycle_manager" {
  metadata {
    annotations = {
      name = "operator-lifecycle-manager"
    }
    name = "operator-lifecycle-manager"
  }
}

# DEBUG
resource "null_resource" "operator_lifecycle_manager_crds" {
  provisioner "local-exec" {
    # environment = {
    #   KUBECONFIG = "${path.root}/creds/config"
    # }
    command = "whoami"
  }
}

# Install the `CustomResourceDefinition` resources separately
resource "null_resource" "operator_lifecycle_manager_crds" {
  provisioner "local-exec" {
    # environment = {
    #   KUBECONFIG = "${path.root}/creds/config"
    # }
    command = "/usr/local/bin/kubectl apply --validate=false -f ${path.module}/crds/crds-${var.operator_lifecycle_manager_version}.yaml"
  }
  depends_on = [
    kubernetes_namespace.operator_lifecycle_manager
  ]
}

# Wait for OLM CRDs completion
resource "null_resource" "operator_lifecycle_manager_crds_wait" {
  provisioner "local-exec" {
    # environment = {
    #   KUBECONFIG = "${path.root}/creds/config"
    # }
    command = "/usr/local/bin/kubectl -n operator-lifecycle-manager wait --for=condition=complete job --all"
  }
  depends_on = [
    null_resource.operator_lifecycle_manager_crds
  ]
}

# Install OLM
resource "null_resource" "operator_lifecycle_manager_install" {
  provisioner "local-exec" {
    # environment = {
    #   KUBECONFIG = "${path.root}/creds/config"
    # }
    command = "/usr/local/bin/kubectl apply --validate=false -f ${path.module}/crds/olm-${var.operator_lifecycle_manager_version}.yaml"
  }
  depends_on = [
    null_resource.operator_lifecycle_manager_crds_wait
  ]
}
