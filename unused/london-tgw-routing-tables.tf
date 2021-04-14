### Create Transit Gateway Routing Tables

## Dev

resource "aws_ec2_transit_gateway_route_table" "london-dev-tgw-routing-table" {
        provider = aws.london
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
   tags = {
   Name      = "TGW-london-Dev"
   RouteType = "dev"
 }
}



## Prod
resource "aws_ec2_transit_gateway_route_table" "london-prod-tgw-routing-table" {
        provider = aws.london
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
   tags = {
   Name      = "TGW-london-prod"
   RouteType = "prod"
 }
}

## Mgmt
resource "aws_ec2_transit_gateway_route_table" "london-mgmt-tgw-routing-table" {
        provider = aws.london
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
   tags = {
   Name      = "TGW-london-mgmt"
   RouteType = "mgmt"
 }
}

## Internet Egress
resource "aws_ec2_transit_gateway_route_table" "london-internet-tgw-routing-table" {
        provider = aws.london
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
   tags = {
   Name      = "TGW-london-internet"
   RouteType = "internet-egress"
 }
}