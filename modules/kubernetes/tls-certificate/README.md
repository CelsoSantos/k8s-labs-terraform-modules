# TLS certificate module

- [Description](#description)
- [Requirements](#requirements)
- [Usage](#usage)
- [Input Variables](#input-variables)
- [Output Variables](#output-variables)
- [References](#references)

## Description

This Terraform module creates TLS secrets in Kubernetes based on [cert-manager](https://github.com/celsosantos/k8s-labs-terraform-modules/tree/master/modules/helm/cert-manager)

## Requirements

* [terraform](https://www.terraform.io/downloads.html) : version >= 0.12.16

## Usage

```hcl
# Module
module "tls_cert" {
  source = "git::ssh://git@github.com/celsosantos/k8s-labs-terraform-modules//modules/kubernetes/tls-certificate/"

  domain_name = "svc.example.com"
  issuer_ref  = "letsencrypt-dns-prod"
  secret_name = "svc_example_com"
  namespace   = "my-ns"
}
```

## Input Variables

| Name        | Description                                     |       Default        | Required |
| ----------- | ----------------------------------------------- | :------------------: | :------: |
| domain_name | DNS record needing TLS                          |          -           |   Yes    |
| issuer_ref  | Issuer used for the certificate                 | letsencrypt-dns-prod |    No    |
| namespace   | Namespace where the secret is stored            |       default        |    No    |
| secret_name | Secret's name that will contain the certificate |          -           |   Yes    |

## Output Variables

NA

## References

* [Cert-manager certificate doc](https://docs.cert-manager.io/en/latest/reference/certificates.html)
* [Cert-manager module](https://github.com/celsosantos/k8s-labs-terraform-modules/tree/master/modules/helm/cert-manager/tmpl)

