variable "datacenter" {
  description = "Datacenter where gateway appliances and VLANs will be deployed."
  type        = string
  default     = ""
}

variable "domain" {
  description = "Domain name for gateway appliances."
  type        = string
  default     = "clouddesigndev.com"
}

variable "iaas_classic_username" {
  description = "Classic IaaS username."
  type        = string
  default     = ""
}

variable "iaas_classic_api_key" {
  description = "Classic IaaS API Key."
  type        = string
  default     = ""
}

variable "ssh_key" {
  description = "SSH key to add to gateway appliances."
  type        = string
  default     = ""
}

variable "name" {
  type        = string
  description = "Name that will be prepended to all resources."
  default     = ""
}
