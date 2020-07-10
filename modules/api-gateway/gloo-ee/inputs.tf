###############################################################################
# Description: Inputs for Gloo Enterprise Gateway Terraform Module            #
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

variable "discovery_stats" {
  description = "Enable Discovery Prometheus Stats"
  type        = bool
  default     = true
}

variable "gateway_enabled" {
  description = "Enable Gloo Gateway API"
  type        = bool
  default     = true
}

variable "gateway_stats" {
  description = "Enable Gloo Enterprise Gateway Stats"
  type        = bool
  default     = false
}

variable "grafana_password" {
  description = "Password for Grafana User"
  type        = string
  default     = "admin"
}

variable "grafana_url" {
  description = "URL for custom Grafana instance"
  type        = string
  default     = ""
}

variable "grafana_username" {
  description = "Username for Grafana"
  type        = string
  default     = "admin"
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

variable "license_key" {
  description = "Gloo Enterprise Gateway License Key"
  type        = string
}

variable "namespace" {
  description = "Name of the Namespace to create and install Gloo Gateway"
  type        = string
  default     = "gloo-system"
}

variable "prometheus_url" {
  description = "URL for custom Prometheus instance"
  type        = string
  default     = ""
}

variable "release_version" {
  description = "Version of Gloo Enterprise Gateway to install"
  type        = string
  default     = "1.4.2"
}

variable "stats" {
  description = "Enable Gloo Enterprise Gateway Deployment Stats"
  type        = bool
  default     = false
}

