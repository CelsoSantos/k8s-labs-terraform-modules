###############################################################################
# Description: Inputs for tls-certificate Terraform Module                    #
###############################################################################

variable "domain_name" {
  description = "DNS record needing TLS"
  type        = string
}

variable "issuer_ref" {
  description = "Issuer used for the certificate"
  type        = string
  default     = "letsencrypt-dns-prod"
}

variable "namespace" {
  description = "Namespace where to store the secret"
  type        = string
  default     = "default"
}

variable "secret_name" {
  description = "Secret's name that will contain the certificate"
  type        = string
}

