
### Create Transit Gateway Routing Tables

## Dev

resource "aws_ec2_transit_gateway_route_table" "frankfurt-dev-tgw-routing-table" {
        provider = aws.frankfurt
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-FRANKFURT.id}"
   tags = {
   Name      = "TGW-frankfurt-Dev"
   RouteType = "dev"
 }
}

## Prod
resource "aws_ec2_transit_gateway_route_table" "frankfurt-prod-tgw-routing-table" {
        provider = aws.frankfurt
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-FRANKFURT.id}"
   tags = {
   Name      = "TGW-frankfurt-prod"
   RouteType = "prod"
 }
}

## Mgmt
resource "aws_ec2_transit_gateway_route_table" "frankfurt-mgmt-tgw-routing-table" {
        provider = aws.frankfurt
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-FRANKFURT.id}"
   tags = {
   Name      = "TGW-frankfurt-mgmt"
   RouteType = "mgmt"
 }
}
