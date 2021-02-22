resource "ibm_is_vpn_gateway" "vpn_gateway" {
  name           = "${var.name}-vpn-gw"
  subnet         = data.ibm_is_subnet.subnet.id
  resource_group = data.ibm_resource_group.group.id
  tags           = ["project:${var.name}"]
}

resource "ibm_is_vpn_gateway_connection" "vpn_gw_connection" {
  name          = "${var.name}-vpn-connection"
  vpn_gateway   = ibm_is_vpn_gateway.vpn_gateway.id
  peer_address  = ibm_is_vpn_gateway.vpn_gateway.public_ip_address
  preshared_key = var.preshared_key
  local_cidrs   = [data.ibm_is_subnet.subnet.ipv4_cidr_block]
  peer_cidrs    = [var.remote_cidr]
}
