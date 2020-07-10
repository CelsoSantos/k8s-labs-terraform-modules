# Plex bootstrap

- [Description](#description)
- [Requirements](#requirements)
- [Input Variables](#input-variables)
- [Output Variables](#output-variables)
- [References](#references)

## Description

This repo provides Terraform module to create a kubernetes cluster used to boostrap test environments.

## Requirements

- [terraform](https://www.terraform.io/downloads.html) : version >= 0.12.16
- An account on [Terraform Cloud](https://app.terraform.io) : if using shared remote states
  - Create a [free tier account](https://www.terraform.io/docs/enterprise/free/index.html)
  - Create or ask to join an organization
  - Create an [access token](https://app.terraform.io/app/settings/tokens) and [save it](https://www.terraform.io/docs/enterprise/free/index.html#configure-access-for-the-terraform-cli)

## Input Variables

| Name                        | Description                                                      |   Default    | Required |
| --------------------------- | ---------------------------------------------------------------- | :----------: | :------: |
| account_id                  | AWS account ID                                                   | 000000000000 |   Yes    |
| admin_user                  | IAM username that must have administrative access on the cluster |      -       |   Yes    |
| region                      | EC2 availability zone                                            | eu-central-1 |   Yes    |
| istio_release_chart_version | Chart version to install                                         |   "1.3.5"    |   Yes    |

## Output Variables

NA

## References

- [Terraform CLI Configuration File](https://www.terraform.io/docs/commands/cli-config.html)
