###############################################################################
# Description: Inputs for Istio Terraform Module                              #
###############################################################################

variable "istio_ca_addr" {
  description = "Address:Port of the CA provider"
  type        = string
  default     = "istio-citadel:8060"
}

variable "istio_ca_provider" {
  description = "Name of the CA provider"
  type        = string
  default     = "Citadel"
}

variable "istio_mtls_enabled" {
  description = "Enable mTLS"
  type        = bool
  default     = true
}

variable "istio_nodeagent_enabled" {
  description = "Enable SDS Node Agent"
  type        = bool
  default     = true
}

variable "istio_release_chart_version" {
  description = "Chart version to install"
  type        = string
  default     = "1.3.5"
}

variable "istio_sds_enabled" {
  description = "Enable SDS"
  type        = bool
  default     = true
}

