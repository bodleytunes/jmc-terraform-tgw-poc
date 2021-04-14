resource "aws_ec2_transit_gateway_route_table" "london-dev-tgw-routing-table" {
        provider = aws.london
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
   tags = {
   Name      = "TGW-london-Dev"
   RouteType = "dev"
 }
}

resource "aws_ec2_transit_gateway_route_table" "london-prod-tgw-routing-table" {
        provider = aws.london
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
   tags = {
   Name      = "TGW-london-prod"
   RouteType = "prod"
 }
}


resource "aws_ec2_transit_gateway_route_table" "london-test-tgw-routing-table" {
        provider = aws.london
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
   tags = {
   Name      = "TGW-london-test"
   RouteType = "test"
 }
}

## MGMT

resource "aws_ec2_transit_gateway_route_table" "london-mgmt-tgw-routing-table" {
        provider = aws.london
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
   tags = {
   Name      = "TGW-london-mgmt"
   RouteType = "mgmt"
 }
}

## VPN1
resource "aws_ec2_transit_gateway_route_table" "london-vpn1-tgw-routing-table" {
        provider = aws.london
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
   tags = {
   Name      = "TGW-london-vpn1"
   RouteType = "vpn1"
 }
}