### frankfurt ##

### tgw route table propagations (route leaking)

## DEV ROUTES

## dev-dev

resource "aws_ec2_transit_gateway_route_table_propagation" "frankfurt-dev-to-dev" {
          provider = aws.frankfurt
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-frankfurt-dev-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.frankfurt-dev-tgw-routing-table.id}"


}
## dev to mgmt
resource "aws_ec2_transit_gateway_route_table_propagation" "frankfurt-dev-to-mgmt" {
          provider = aws.frankfurt
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-frankfurt-dev-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.frankfurt-mgmt-tgw-routing-table.id}"

}

## mgmt to dev

resource "aws_ec2_transit_gateway_route_table_propagation" "frankfurt-prod-to-prod" {
          provider = aws.frankfurt
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-frankfurt-prod-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.frankfurt-prod-tgw-routing-table.id}"


}
## prod to mgmt
resource "aws_ec2_transit_gateway_route_table_propagation" "frankfurt-prod-to-mgmt" {
          provider = aws.frankfurt
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-frankfurt-prod-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.frankfurt-mgmt-tgw-routing-table.id}"


}
## mgmt to mgmt
resource "aws_ec2_transit_gateway_route_table_propagation" "frankfurt-mgmt-to-mgmt" {
          provider = aws.frankfurt
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-frankfurt-mgmt-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.frankfurt-mgmt-tgw-routing-table.id}"

}
## mgmt to dev
resource "aws_ec2_transit_gateway_route_table_propagation" "frankfurt-mgmt-to-dev" {
          provider = aws.frankfurt
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-frankfurt-mgmt-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.frankfurt-dev-tgw-routing-table.id}"


}
## mgmt to prod
resource "aws_ec2_transit_gateway_route_table_propagation" "frankfurt-mgmt-to-prod" {
          provider = aws.frankfurt
  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-frankfurt-mgmt-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.frankfurt-prod-tgw-routing-table.id}"


}