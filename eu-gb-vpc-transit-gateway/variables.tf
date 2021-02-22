variable "region" {
  type        = string
  description = "The region where the VPC resources will be deployed."
  default     = ""
}

variable "ssh_key" {
  type        = string
  description = "The SSH Key that will be added to the compute instances in the region."
  default     = ""
}

variable "default_instance_profile" {
  type    = string
  default = "bx2-2x8"
}

variable "os_image" {
  type        = string
  description = "OS Image to use for VPC instances. Default is currently Ubuntu 18."
  default     = "ibm-ubuntu-18-04-1-minimal-amd64-2"
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

variable "global" {
  type        = bool
  description = "Enable global routing on the TGW. Default is false."
  default     = false
}