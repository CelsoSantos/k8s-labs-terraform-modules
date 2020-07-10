###############################################################################
# Description: Inputs for cert-manager Terraform Module                       #
###############################################################################

variable "account_id" {
  description = "AWS account"
  type        = string
  default     = ""
}

variable "chart_version" {
  description = "Chart version to install"
  type        = string
  default     = "0.15.2"
}

variable "region" {
  description = "EC2 availability zone"
  type        = string
  default     = ""
}

variable "route53_access_key_id" {
  description = "Route53 account key ID"
  type        = string
  default     = ""
}

variable "route53_secret_access_key" {
  description = "Route53 account private key"
  type        = string
  default     = ""
}

variable "route53_secret_name" {
  description = "Secret name for storing route53_secret_access_key"
  type        = string
  default     = "r53-secret"
}

