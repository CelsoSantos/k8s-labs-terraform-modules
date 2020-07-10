# Gloo Gateway module

- [Description](#description)
- [Requirements](#requirements)
- [Usage](#usage)
- [Input Variables](#input-variables)
- [Output Variables](#output-variables)
- [References](#references)

## Description

This terraform module installs Gloo Gateway CE on a Kubernetes cluster

## Requirements

* [terraform](https://www.terraform.io/downloads.html) : version >= 0.12.16
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) : version >= 1.15.0

## Usage

```hcl
# Module
module "gloo_gw_ce" {
  source = "git::ssh://git@github.com/celsosantos/k8s-labs-terraform-modules//modules/networking/gloo-oss/"

  discovery_enabled  = true
  discovery_fds_mode = "WHITELIST"
  gateway_enabled    = true
  knative_enabled    = true
  knative_version    = "0.10.0"
  namespace          = "gloo-system"
  release_version    = "1.2.1"
}
```

## Input Variables

| Name               | Description                                              |    Default    | Required |
| ------------------ | -------------------------------------------------------- | :-----------: | :------: |
| discovery_enabled  | Enable Discovery Features                                |     true      |    No    |
| discovery_fds_mode | Mode for Function Discovery                              |  "WHITELIST"  |    No    |
| gateway_enabled    | Enable Gloo Gateway API                                  |     true      |    No    |
| knative_enabled    | Enable Knative                                           |     false     |    No    |
| knative_version    | Version of Knative to install                            |   "0.10.0"    |    No    |
| namespace          | Name of the Namespace to create and install Gloo Gateway | "gloo-system" |    No    |
| release_version    | Version of Gloo Gateway to install                       |    "1.2.1"    |    No    |

## Output Variables

NA

## References

* [Gloo Releases](https://github.com/solo-io/gloo/releases)

