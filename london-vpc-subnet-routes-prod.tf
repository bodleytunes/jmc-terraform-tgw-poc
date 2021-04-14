/* 

variable "london_prod_subnets" {
  description = "Subnet CIDRs for prod"
  # this could be further simplified / computed using cidrsubnet() etc.
  # https://www.terraform.io/docs/configuration/interpolation.html#cidrsubnet-iprange-newbits-netnum-
  default = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
  type = "list"
}

## VPC

variable "london_vpc_cidr_prod" {
  default = "10.1.0.0/16"
} */


resource "aws_vpc" "prod" {
    provider = aws.london
  cidr_block = "${var.london_vpc_cidr_prod}"
  tags = {
    Name = "vpc-london-prod"
   }
}

## Subnets

resource "aws_subnet" "prod" {
        provider = aws.london

  count = "${length(var.london_prod_subnets)}"

  vpc_id = "${aws_vpc.prod.id}"
  cidr_block = "${var.london_prod_subnets[count.index]}"
  availability_zone = "${var.london_availability_zone_names[count.index]}"

  tags = {
    Name = "subnet-london-prod"
   }
  
}


# Route Tables
resource "aws_route_table" "prod" {
        provider = aws.london

  vpc_id = "${aws_vpc.prod.id}"
    tags = {
    Name = "rt-subnet-london-prod"
    }

  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  }
  


}

resource "aws_route_table_association" "prod" {
            provider = aws.london

  count = "${length(var.london_prod_subnets)}"

  subnet_id      = "${element(aws_subnet.prod.*.id, count.index)}"
  route_table_id = "${aws_route_table.prod.id}"
}

resource "aws_security_group" "london-prod" {
          provider = aws.london

  name        = "london-prod"
  description = "Default prod Security Group"
  vpc_id      = "${aws_vpc.prod.id}"

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

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-london-prod-attach" {
 ## subnets returns tuple so grab single element
       provider = aws.london

  subnet_ids         = "${aws_subnet.prod.*.id}"
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  vpc_id             = "${aws_vpc.prod.id}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

   tags = {
    Name = "vpc-london-prod"
    Terraform = "true"
    Environment = "prod"
  }

}

## TGW RT Associations

resource "aws_ec2_transit_gateway_route_table_association" "london-prod-tgw-rt-association" {

        provider = aws.london


  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-prod-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-prod-tgw-routing-table.id}"

}