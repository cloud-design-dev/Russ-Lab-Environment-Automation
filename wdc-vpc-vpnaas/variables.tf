variable "region" {
  type        = string
  description = "The region where the VPC resources will be deployed."
  default     = ""
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC where the VPN Gateway will be created."
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

variable preshared_key {
  type        = string
  description = "Preshared key used for VPN connection."
  default     = ""
}

variable "remote_cidr" {
  type        = string
  description = "Remote CIDR that will be exposed to your VPC resources via the VPN connection."
  default     = ""
}

variable "subnet" {
  type        = string
  description = "Name of VPN subnet to expose to the remote side of the VPN."
  default     = ""
}