###############################################################################
# Description: Inputs for Gloo Gateway Terraform Module                       #
###############################################################################

variable "discovery_enabled" {
  description = "Enable Discovery Features"
  type        = bool
  default     = true
}

variable "discovery_fds_mode" {
  description = "Mode for Function Discovery"
  type        = string
  default     = "WHITELIST"
}

variable "gateway_enabled" {
  description = "Enable Gloo Gateway API"
  type        = bool
  default     = true
}

variable "knative_enabled" {
  description = "Enable Knative"
  type        = bool
  default     = false
}

variable "knative_version" {
  description = "Knative Version to install"
  type        = string
  default     = "0.10.0"
}

variable "namespace" {
  description = "Name of the Namespace to create and install Gloo Gateway"
  type        = string
  default     = "gloo-system"
}

variable "release_version" {
  description = "Version of Gloo Gateway to install"
  type        = string
  default     = "1.4.6"
}

