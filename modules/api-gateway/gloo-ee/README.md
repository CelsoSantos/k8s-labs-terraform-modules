# Gloo Enterprise Gateway module

- [Description](#description)
- [Requirements](#requirements)
- [Usage](#usage)
- [Input Variables](#input-variables)
- [Output Variables](#output-variables)
- [References](#references)

## Description

This terraform module installs Gloo Enterprise Gateway on a Kubernetes cluster

## Requirements

* [terraform](https://www.terraform.io/downloads.html) : version >= 0.12.16
* [helm](https://kubernetes.io/docs/tasks/tools/install-kubectl/) : version >= 1.15.0

## Usage

```hcl
# Module
module "gloo_gw" {
  source = "git::ssh://git@github.com/celsosantos/k8s-labs-terraform-modules//modules/networking/gloo-ee/"

  discovery_enabled      = true
  discovery_fds_mode     = "WHITELIST"
  discovery_stats        = true
  gateway_enabled        = true
  gateway_stats          = true
  grafana_password       = "PASSWORD"
  grafana_url            = "protocol://svc-name.namespace.svc:port"
  grafana_username       = "USERNAME"
  knative_enabled        = false
  knative_version        = "0.10.0"
  license_key            = "LICENSE_KEY"
  namespace              = "gloo-system"
  prometheus_url         = "protocol://svc-name.namespace.svc:port"
  release_version        = "1.2.0"
  stats                  = true
}
```

## Input Variables

| Name               | Description                                              |    Default    | Required |
| ------------------ | -------------------------------------------------------- | :-----------: | :------: |
| discovery_enabled  | Enable Discovery Features                                |     true      |    No    |
| discovery_fds_mode | Mode for Function Discovery                              |  "WHITELIST"  |    No    |
| discovery_stats    | Enable Discovery Prometheus Stats                        |     true      |    No    |
| gateway_enabled    | Enable Gloo Gateway API                                  |     true      |    No    |
| gateway_stats      | Enable Gloo Gateway Prometheus Stats                     |     true      |    No    |
| grafana_password   | Password for Grafana User                                |       -       |   Yes    |
| grafana_url        | URL for custom Grafana instance                          |       -       |   Yes    |
| grafana_username   | Username for Grafana                                     |       -       |   Yes    |
| knative_enabled    | Enable Knative                                           |     false     |    No    |
| knative_version    | Version of Knative to install                            |   "0.10.0"    |    No    |
| license_key        | Gloo Enterprise Gateway License Key                      |       -       |   Yes    |
| namespace          | Name of the Namespace to create and install Gloo Gateway | "gloo-system" |    No    |
| prometheus_url     | URL for custom Prometheus instance                       |       -       |   Yes    |
| release_version    | Version of Gloo Gateway to install                       |    "1.2.0"    |    No    |
| stats              | Enable Prometheus Stats                                  |     true      |    No    |

## Output Variables

NA

## References

* [Gloo Releases](https://github.com/solo-io/gloo/releases)

