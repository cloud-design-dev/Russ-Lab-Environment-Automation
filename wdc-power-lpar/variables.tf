variable "region" {
  type        = string
  description = "The region where the Power resources will be deployed."
  default     = ""
}

variable "resource_group" {
  type        = string
  description = "Resource group where resources will be deployed."
  default     = ""
}

variable "name" {
  type        = string
  description = "Name that will be prepended to all resources."
  default     = ""
}
