module vpc {
  source         = "git::https://github.com/cloud-design-dev/IBM-Cloud-VPC-Module.git"
  name           = "${var.name}-vpc"
  resource_group = data.ibm_resource_group.group.id
  tags           = ["project:${var.name}", "region:${var.region}"]
  classic_access = false
}

module public_gateway {
  source            = "git::https://github.com/cloud-design-dev/IBM-Cloud-VPC-Public-Gateway-Module.git"
  name              = "${var.name}-public-gateway"
  zone              = data.ibm_is_zones.mzr.zones[0]
  vpc_id            = module.vpc.id
  resource_group_id = data.ibm_resource_group.group.id
  tags              = ["project:${var.name}", "region:${var.region}", "zone:${data.ibm_is_zones.mzr.zones[0]}"]
}

module subnet {
  source         = "git::https://github.com/cloud-design-dev/IBM-Cloud-VPC-Subnet-Module.git"
  name           = "${var.name}-subnet"
  resource_group = data.ibm_resource_group.group.id
  network_acl    = module.vpc.default_network_acl
  address_count  = "128"
  vpc            = module.vpc.id
  zone           = data.ibm_is_zones.mzr.zones[0]
  public_gateway = module.public_gateway.id
}

resource "ibm_is_security_group" "project" {
  name           = "${var.name}-security-group"
  vpc            = module.vpc.id
  resource_group = data.ibm_resource_group.group.id
}


resource "ibm_is_security_group_rule" "all_in_rule" {
  group     = ibm_is_security_group.project.id
  direction = "inbound"
  remote    = "0.0.0.0"

}

resource "ibm_is_security_group_rule" "all_out_rule" {
  group     = ibm_is_security_group.project.id
  direction = "outbound"
  remote    = "52.116.37.6"
}

resource "ibm_is_instance" "instance" {
  name    = "${var.name}-instance"
  image   = data.ibm_is_image.default.id
  profile = var.default_instance_profile

  primary_network_interface {
    subnet          = module.subnet.id
    security_groups = [ibm_is_security_group.project.id]
  }

  resource_group = data.ibm_resource_group.group.id
  tags           = ["project:${var.name}", "region:${var.region}"]
  vpc            = module.vpc.id
  zone           = data.ibm_is_zones.mzr.zones[0]
  keys           = [data.ibm_is_ssh_key.ssh_key.id]
}

resource "ibm_tg_gateway" "wdc" {
  name           = "${var.name}-transit-gateway"
  location       = var.region
  global         = var.global
  resource_group = data.ibm_resource_group.group.id
}

resource "ibm_tg_connection" "wdc_vpc_connection" {
  gateway      = ibm_tg_gateway.wdc.id
  network_type = "vpc"
  name         = "${var.name}-vpc-tg-connection"
  network_id   = module.vpc.crn
}