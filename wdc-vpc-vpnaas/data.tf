
data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_is_subnet" "subnet" {
  region = var.subnet
}

data "ibm_is_vpc" "vpc" {
  name = var.vpc_name
}