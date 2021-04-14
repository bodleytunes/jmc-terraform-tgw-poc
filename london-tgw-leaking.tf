### LONDON ##

### tgw route table propagations (route leaking)


## dev-dev

resource "aws_ec2_transit_gateway_route_table_propagation" "london-dev-to-dev" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-dev-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-dev-tgw-routing-table.id}"

}
## prod-prod
resource "aws_ec2_transit_gateway_route_table_propagation" "london-prod-to-prod" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-prod-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-prod-tgw-routing-table.id}"

}

## test-test
resource "aws_ec2_transit_gateway_route_table_propagation" "london-test-to-test" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-test-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-test-tgw-routing-table.id}"

}

## mgmt-mgmt  (management learns all other networks)
# Managements own routes
resource "aws_ec2_transit_gateway_route_table_propagation" "london-mgmt-to-mgmt" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-mgmt-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-mgmt-tgw-routing-table.id}"

}
# Leaking from management to other tables
resource "aws_ec2_transit_gateway_route_table_propagation" "london-mgmt-to-dev" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-mgmt-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-dev-tgw-routing-table.id}"

}
resource "aws_ec2_transit_gateway_route_table_propagation" "london-mgmt-to-prod" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-mgmt-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-prod-tgw-routing-table.id}"

}
resource "aws_ec2_transit_gateway_route_table_propagation" "london-mgmt-to-test" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-mgmt-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-test-tgw-routing-table.id}"

}
## Reverse direction leaking to mgmt
resource "aws_ec2_transit_gateway_route_table_propagation" "london-dev-to-mgmt" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-dev-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-mgmt-tgw-routing-table.id}"

}
resource "aws_ec2_transit_gateway_route_table_propagation" "london-prod-to-mgmt" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-prod-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-mgmt-tgw-routing-table.id}"

}
resource "aws_ec2_transit_gateway_route_table_propagation" "london-test-to-mgmt" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-test-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-mgmt-tgw-routing-table.id}"

}
### vpn1 (hetzner)
resource "aws_ec2_transit_gateway_route_table_propagation" "london-vpn1-to-vpn1" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-vpn1-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-vpn1-tgw-routing-table.id}"

}

resource "aws_ec2_transit_gateway_route_table_propagation" "london-dev-to-vpn1" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-dev-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-vpn1-tgw-routing-table.id}"

}

resource "aws_ec2_transit_gateway_route_table_propagation" "london-vpn1-to-dev" {
          provider = aws.london
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-vpn1-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-dev-tgw-routing-table.id}"

}