# Operator Lifecycle Manager module

- [Description](#description)
- [Requirements](#requirements)
- [Usage](#usage)
- [Input Variables](#input-variables)
- [Output Variables](#output-variables)
- [References](#references)

## Description

This terraform module installs the Operator Lifecycle Manager on a kubernetes cluster

## Requirements

* [terraform](https://www.terraform.io/downloads.html) : version >= 0.12.16
* [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) : version >= 1.15.0

## Usage

```hcl
# Module
module "operator-lifecycle-manager" {
  source = "git::ssh://git@github.com/celsosantos/k8s-labs-terraform-modules//modules/operator/lifecycle-manager/"

  operator_lifecycle_manager_version = "0.13.0"
}
```

## Input Variables

| Name                               | Description               | Default  | Required |
| ---------------------------------- | ------------------------- | :------: | :------: |
| operator_lifecycle_manager_version | Version of OLM to install | "0.13.0" |    No    |

## Output Variables

NA

## References

* [Operator Lifecycle Manager](https://github.com/operator-framework/operator-lifecycle-manager)

