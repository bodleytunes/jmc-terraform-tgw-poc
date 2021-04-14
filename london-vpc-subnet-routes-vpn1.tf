/* 

variable "london_vpn1_subnets" {
  description = "Subnet CIDRs for vpn1"
  # this could be further simplified / computed using cidrsubnet() etc.
  # https://www.terraform.io/docs/configuration/interpolation.html#cidrsubnet-iprange-newbits-netnum-
  default = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
  type = "list"
}

## VPC

variable "london_vpc_cidr_vpn1" {
  default = "10.1.0.0/16"
} */


resource "aws_vpc" "vpn1" {
    provider = aws.london
  cidr_block = "${var.london_vpc_cidr_vpn1}"
  tags = {
    Name = "vpc-london-vpn1"
   }
}

## Subnets

resource "aws_subnet" "vpn1" {
        provider = aws.london

  count = "${length(var.london_vpn1_subnets)}"

  vpc_id = "${aws_vpc.vpn1.id}"
  cidr_block = "${var.london_vpn1_subnets[count.index]}"
  availability_zone = "${var.london_availability_zone_names[count.index]}"

  tags = {
    Name = "subnet-london-vpn1"
   }
  
}


# Route Tables
resource "aws_route_table" "vpn1" {
        provider = aws.london

  vpc_id = "${aws_vpc.vpn1.id}"
    tags = {
    Name = "rt-subnet-london-vpn1"
    }
  


}

resource "aws_route_table_association" "vpn1" {
            provider = aws.london

  count = "${length(var.london_vpn1_subnets)}"

  subnet_id      = "${element(aws_subnet.vpn1.*.id, count.index)}"
  route_table_id = "${aws_route_table.vpn1.id}"
}

resource "aws_security_group" "london-vpn1" {
          provider = aws.london

  name        = "london-vpn1"
  description = "Default vpn1 Security Group"
  vpc_id      = "${aws_vpc.vpn1.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

### Create Transit Gateway Attachements

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-london-vpn1-attach" {
 ## subnets returns tuple so grab single element
       provider = aws.london

  subnet_ids         = "${aws_subnet.vpn1.*.id}"
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  vpc_id             = "${aws_vpc.vpn1.id}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

   tags = {
    Name = "vpc-london-vpn1"
    Terraform = "true"
    Environment = "vpn1"
  }

}

## TGW RT Associations

resource "aws_ec2_transit_gateway_route_table_association" "london-vpn1-tgw-rt-association" {

        provider = aws.london


  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-vpn1-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-vpn1-tgw-routing-table.id}"

}