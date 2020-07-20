###############################################################################
# Description: Main for cert-manager Terraform Module                         #
###############################################################################


# Create the namespace for cert-manager
resource "kubernetes_namespace" "cert_manager" {
  metadata {
    annotations = {
      name = var.namespace
    }
    # kubectl label namespace cert-manager certmanager.k8s.io/disable-validation="true"
    labels = {
      "certmanager.k8s.io/disable-validation" = "true"
    }
    name = var.namespace
  }
}

# Install cert-manager
resource "helm_release" "helm_install_cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "${var.release_version}"
  namespace  = "${var.namespace}"
  atomic     = true

  set {
    name  = "installCRDs"
    value = true
  }
}

# HTTP01
resource "null_resource" "cert_manager_http01" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.cwd}/creds/config"
    }
    command = "/usr/local/bin/kubectl apply -f ${path.module}/tmpl/production-issuer-http.yaml"
  }
  depends_on = [
    null_resource.helm_install_cert_manager
  ]
}

# route53 API key
resource "kubernetes_secret" "route53_secret" {
  metadata {
    name      = var.route53_secret_name
    namespace = "cert-manager"
  }

  data = {
    secret-access-key = var.route53_secret_access_key
  }

  type = "Opaque"
}

# DNS01
data "template_file" "cert_manager_prod_issuer_dns" {
  template = file("${path.module}/tmpl/production-issuer-dns.tmpl")

  vars = {
    accessKeyID = var.route53_access_key_id
    account_id  = var.account_id
    region      = var.region
    secret_name = var.route53_secret_name
  }
  depends_on = [
    kubernetes_secret.route53_secret
  ]
}

resource "local_file" "cert_manager_prod_issuer_dns" {
  content  = data.template_file.cert_manager_prod_issuer_dns.rendered
  filename = "${path.module}/creds/production-issuer-dns.yaml"
}

resource "null_resource" "cert_manager_dns01" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/kubectl apply -f ${path.root}/creds/production-issuer-dns.yaml"
  }
  depends_on = [
    null_resource.helm_install_cert_manager,
    local_file.cert_manager_prod_issuer_dns
  ]
}

