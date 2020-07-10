# Istio module

- [Description](#description)
- [Requirements](#requirements)
- [Usage](#usage)
- [Input Variables](#input-variables)
- [Output Variables](#output-variables)
- [References](#references)

## Description

This terraform module installs istio service mesh, enabled with SDS, on a kubernetes cluster

## Requirements

* [terraform](https://www.terraform.io/downloads.html) : version >= 0.12.16
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) : version >= 1.15.0

## Usage

```hcl
# Module
module "istio" {
  source = "git::ssh://git@github.com/celsosantos/k8s-labs-terraform-modules//modules/helm/istio/"

  istio_ca_addr               = "istio-citadel:8060"
  istio_ca_provider           = "Citadel"
  istio_mtls_enabled          = true
  istio_nodeagent_enabled     = true
  istio_release_chart_version = "1.3.5"
  istio_sds_enabled           = true
}
```

## Input Variables

| Name                        | Description                     |       Default        | Required |
| --------------------------- | ------------------------------- | :------------------: | :------: |
| istio_ca_addr               | Address:Port of the CA provider | "istio-citadel:8060" |    No    |
| istio_ca_provider           | Name of the CA provider         |      "Citadel"       |    No    |
| istio_mtls_enabled          | Enable mTLS                     |         true         |    No    |
| istio_nodeagent_enabled     | Enable SDS Node Agent           |         true         |    No    |
| istio_release_chart_version | Chart version to install        |        1.3.5         |    No    |
| istio_sds_enabled           | Enable SDS                      |         true         |    No    |

## Output Variables

NA

## References

* [Customizable Install with Helm](https://istio.io/docs/setup/install/helm/)

