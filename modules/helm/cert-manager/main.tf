###############################################################################
# Description: Main for cert-manager Terraform Module                         #
###############################################################################


# Create the namespace for cert-manager
resource "kubernetes_namespace" "cert_manager" {
  metadata {
    annotations = {
      name = "cert-manager"
    }
    # kubectl label namespace cert-manager certmanager.k8s.io/disable-validation="true"
    labels = {
      "certmanager.k8s.io/disable-validation" = "true"
    }
    name = "cert-manager"
  }
}

# Install the `CustomResourceDefinition` resources separately
resource "null_resource" "cert_manager_crds" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v${var.chart_version}/cert-manager.crds.yaml" # ${path.module}/crds/00-crds-${var.chart_version}.yaml"
  }
  depends_on = [
    kubernetes_namespace.cert_manager
  ]
}

# Add the Jetstack Helm repository and update your local Helm chart repository cache
resource "null_resource" "helm_repo_jetstack" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/helm repo add jetstack https://charts.jetstack.io && /usr/local/bin/helm repo update"
  }
  depends_on = [
    null_resource.cert_manager_crds
  ]
}

# Install cert-manager
resource "null_resource" "helm_install_cert_manager" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
    }
    command = "/usr/local/bin/helm upgrade cert-manager --atomic --install --version v${var.chart_version} --namespace cert-manager jetstack/cert-manager"
  }
  depends_on = [
    null_resource.helm_repo_jetstack
  ]
}

# HTTP01
resource "null_resource" "cert_manager_http01" {
  provisioner "local-exec" {
    environment = {
      KUBECONFIG = "${path.root}/creds/config"
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
  filename = "${path.root}/creds/production-issuer-dns.yaml"
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

