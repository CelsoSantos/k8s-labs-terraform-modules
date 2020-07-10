###############################################################################
# Description: Inputs for Operator Lifecycle Manager Terraform Module         #
###############################################################################

variable "operator_lifecycle_manager_version" {
  description = "OLM version"
  type        = string
  default     = "0.13.0"
}
