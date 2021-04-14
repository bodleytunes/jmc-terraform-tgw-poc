variable "vlan-dev" {
    vlan-dev = "2030"
}
variable "vlan-prod" {
    vlan-dev = "2031"
}
variable "remote-asn-dev" {
  remote-asn-dev = "65098"
}
variable "connection-id" {
  connection-id = "dxcon-fh2exn8s"
}
variable "vif-dev" {
  vif-ixreach-dev = "BKGC_DEV_P2P_FFURT_to_AMS"
}
variable "vif-prod" {
  vif-ixreach-prod = "vif-ixreach-prod"
}
variable "bgp-auth-key" {
  bgp-auth-key = "MS4JQ8hq"
}

### Create Dev
resource "aws_dx_private_virtual_interface" "ix-reach-frankfurt-dev" {
  connection_id = "${var.connection-id}"

  name           = "${var.vif-dev}"
  vlan           = "${var.vlan-dev}"
  address_family = "ipv4"
  bgp_asn        =  "${var.remote-asn-dev}"

  mtu = "9001"

  bgp_auth_key = "${var.bgp_auth_key}"
}