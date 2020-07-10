###############################################################################
# Description: Main for tls-certificate Terraform Module                      #
###############################################################################

# Template data
data "template_file" "tls_certificate" {
  template = file("${path.module}/tmpl/certificate.tmpl")

  vars = {
    domain_name = var.domain_name
    issuer_ref  = var.issuer_ref
    namespace   = var.namespace
    secret_name = var.secret_name
  }
}

# Render certificate config-map
resource "local_file" "tls_certificate" {
  content  = data.template_file.tls_certificate.rendered
  filename = "${path.root}/creds/${var.secret_name}.yaml"
}

# Import certificate config-map
resource "null_resource" "tls_certificate" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/kubectl apply -f ${path.root}/creds/${var.secret_name}.yaml"
  }
  depends_on = [
    local_file.tls_certificate
  ]
}

