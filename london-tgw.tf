

### Create Transit Gateway

resource "aws_ec2_transit_gateway" "TGW-LONDON" {

      provider = aws.london




  description = "Transit Gateway London Region"
  amazon_side_asn = var.london-asn
  auto_accept_shared_attachments = "disable"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  vpn_ecmp_support = "enable"


      tags = {
   Name      = "TGW-London"
 }
}

### Create Transit Gateway Attachements

/* resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-london-dev-attach-1" {
 ## subnets returns tuple so grab single element
       provider = aws.london

  subnet_ids         = ["${element(module.vpc-london-dev.private_subnets, 0)}", "${element(module.vpc-london-dev.private_subnets, 1)}","${element(module.vpc-london-dev.private_subnets, 2)}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  vpc_id             = "${(module.vpc-london-dev.vpc_id)}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

   tags = {
    Name = "vpc-london-dev"
    Terraform = "true"
    Environment = "dev"
  }

}
 */
## Prod TGW Attachment
/* resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-london-prod-attach-1" {
      provider = aws.london

 ## subnets returns tuple so grab single element
   subnet_ids         = ["${element(module.vpc-london-prod.private_subnets, 0)}", "${element(module.vpc-london-prod.private_subnets, 1)}","${element(module.vpc-london-prod.private_subnets, 2)}"]
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  vpc_id             = "${(module.vpc-london-prod.vpc_id)}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

  tags = {
    Name = "vpc-london-prod"
    Terraform = "true"
    Environment = "prod"
  }

} */

## Mgmt TGW Attachment
/* resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-london-mgmt-attach-1" {
      provider = aws.london
   subnet_ids         = ["${element(module.vpc-london-mgmt.private_subnets, 0)}", "${element(module.vpc-london-mgmt.private_subnets, 1)}","${element(module.vpc-london-mgmt.private_subnets, 2)}"]
 ## subnets returns tuple so grab single element
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  vpc_id             = "${(module.vpc-london-mgmt.vpc_id)}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

tags = {
    Name = "vpc-london-mgmt"
    Terraform = "true"
    Environment = "mgmt"
  }

} */


## Internet TGW Attachment
/* resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-london-internet-attach-1" {
      provider = aws.london
   subnet_ids         = ["${element(module.vpc-london-internet.private_subnets, 0)}"]
 ## subnets returns tuple so grab single element
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  vpc_id             = "${(module.vpc-london-internet.vpc_id)}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

tags = {
    Name = "vpc-london-internet"
    Terraform = "true"
    Environment = "internet"
  }

} */


### tgw route table associations

/* resource "aws_ec2_transit_gateway_route_table_association" "london-dev-tgw-rt-association" {

        provider = aws.london


  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-dev-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-dev-tgw-routing-table.id}"

} */

/* resource "aws_ec2_transit_gateway_route_table_association" "london-prod-tgw-rt-association" {

        provider = aws.london

  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-prod-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-prod-tgw-routing-table.id}"

}

resource "aws_ec2_transit_gateway_route_table_association" "london-mgmt-tgw-rt-association" {

        provider = aws.london

  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-mgmt-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-mgmt-tgw-routing-table.id}"

}


resource "aws_ec2_transit_gateway_route_table_association" "london-internet-tgw-rt-association" {

        provider = aws.london

  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-internet-attach-1.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-internet-tgw-routing-table.id}"

}
 */