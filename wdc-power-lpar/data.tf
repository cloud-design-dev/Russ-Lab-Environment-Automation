
data "ibm_resource_group" "group" {
  name = var.resource_group
}

data "ibm_pi_image" "default" {
  region = var.image
}


