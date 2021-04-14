
### Create Transit Gateway

resource "aws_ec2_transit_gateway" "TGW-FRANKFURT" {

      provider = aws.frankfurt

 

  description = "Transit Gateway Frankfurt Region"
  amazon_side_asn = var.frankfurt-asn
  auto_accept_shared_attachments = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  vpn_ecmp_support = "enable"
}

### Create Transit Gateway Attachments
## Dev TGW Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-frankfurt-dev-attach-1" {
      provider = aws.frankfurt

 ## subnets returns tuple so grab single element
  subnet_ids         = ["${element(module.vpc-frankfurt-dev.private_subnets, 0)}", "${element(module.vpc-frankfurt-dev.private_subnets, 1)}","${element(module.vpc-frankfurt-dev.private_subnets, 2)}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-FRANKFURT.id}"
  vpc_id             = "${(module.vpc-frankfurt-dev.vpc_id)}"

    transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
   Name      = "TGW-attach-Dev"
   AttachType = "dev"
 }
}

## Prod TGW Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-frankfurt-prod-attach-1" {
      provider = aws.frankfurt

 ## subnets returns tuple so grab single element
   subnet_ids         = ["${element(module.vpc-frankfurt-prod.private_subnets, 0)}", "${element(module.vpc-frankfurt-prod.private_subnets, 1)}","${element(module.vpc-frankfurt-prod.private_subnets, 2)}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-FRANKFURT.id}"
  vpc_id             = "${(module.vpc-frankfurt-prod.vpc_id)}"

    transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
   Name      = "TGW-attach-prod"
   AttachType = "prod"
 }
}

## Mgmt TGW Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-frankfurt-mgmt-attach-1" {
      provider = aws.frankfurt

 ## subnets returns tuple so grab single element
   subnet_ids         = ["${element(module.vpc-frankfurt-mgmt.private_subnets, 0)}", "${element(module.vpc-frankfurt-mgmt.private_subnets, 1)}","${element(module.vpc-frankfurt-mgmt.private_subnets, 2)}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-FRANKFURT.id}"
  vpc_id             = "${(module.vpc-frankfurt-mgmt.vpc_id)}"

    transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

 tags = {
   Name      = "TGW-attach-mgmt"
   AttachType = "mgmt"
 }

}
