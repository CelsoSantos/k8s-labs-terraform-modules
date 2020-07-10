# Cert-manager module

- [Description](#description)
- [Requirements](#requirements)
- [Usage](#usage)
- [Input Variables](#input-variables)
- [Output Variables](#output-variables)
- [References](#references)

## Description

This terraform module install cert-manager on a kubernetes cluster

## Requirements

* [terraform](https://www.terraform.io/downloads.html) : version >= 0.12.16
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) : version >= 1.15.0
* [helm](https://github.com/helm/helm/releases) : version >= 3.0.0

## Usage

```hcl
# Module
module "cert-manger" {
  source = "git::ssh://git@github.com/celsosantos/k8s-labs-terraform-modules//modules/helm/cert-manager/"

  account_id                = "000000000000"
  chart_version             = "0.12.0"
  region                    = "eu-central-1"
  route53_access_key_id     = "XXXXXXXXXXXXXXXX"
  route53_secret_access_key = "<secret>"
  route53_secret_name       = "my-secret"
}
```

## Input Variables

| Name                      | Description               |  Default   | Required |
| ------------------------- | ------------------------- | :--------: | :------: |
| account_id                | AWS Account ID            |     -      |   Yes    |
| chart_version             | Chart version to install  |   0.12.0   |    No    |
| region                    | EC2 availability zone     |     -      |   Yes    |
| route53_access_key_id     | Route53 account key ID    |     -      |   Yes    |
| route53_secret_access_key | Route53 secret access key |     -      |   Yes    |
| route53_secret_name       | Route53 secret access key | r53-secret |    No    |

## Output Variables

NA

## References

* [Install cert-manager on Kubernetes](https://cert-manager.io/docs/installation/kubernetes/)
* [Verifying the installation](https://cert-manager.io/docs/installation/kubernetes/#verifying-the-installation)

