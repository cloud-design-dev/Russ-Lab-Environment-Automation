resource "ibm_resource_instance" "power_vs_group" {
  name              = "${var.name}-power-systems"
  service           = "power-iaas"
  plan              = "power-virtual-server-group"
  location          = var.region 
  resource_group_id = data.ibm_resource_group.group.id
  tags              = ["tag1", "tag2"]
}

resource "ibm_pi_network" "power_network" {
  count                = 1
  pi_network_name      = "power-network"
  pi_cloud_instance_id = ibm_resource_instance.power_vs_group.id 
  pi_network_type      = "vlan"
  pi_cidr              = "<Network in CIDR notation (192.168.0.0/24)>"
  pi_dns               = [<"DNS Servers">]
}

resource "ibm_pi_instance" "power_instance" {
    pi_memory             = "4"
    pi_processors         = "2"
    pi_instance_name      = "${var.name}-power-system-instance"
    pi_proc_type          = "shared"
    pi_image_id           = data.ibm_pi_image.powerimages.id
    pi_network_ids        = ibm_pi_public_network.power_network.id
    pi_key_pair_name      = data.ibm_pi_key.key.key_id
    pi_sys_type           = "s922"
    pi_cloud_instance_id  = ibm_resource_instance.power_vs_group.id
    pi_pin_policy         = "none"
    pi_health_status      = "WARNING"
}

