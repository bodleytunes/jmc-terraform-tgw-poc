/* 

variable "london_dev_subnets" {
  description = "Subnet CIDRs for dev"
  # this could be further simplified / computed using cidrsubnet() etc.
  # https://www.terraform.io/docs/configuration/interpolation.html#cidrsubnet-iprange-newbits-netnum-
  default = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
  type = "list"
}

## VPC

variable "london_vpc_cidr_dev" {
  default = "10.1.0.0/16"
} */


resource "aws_vpc" "dev" {
    provider = aws.london
  cidr_block = "${var.london_vpc_cidr_dev}"
  tags = {
    Name = "vpc-london-dev"
   }
}

## Subnets

resource "aws_subnet" "dev" {
        provider = aws.london

  count = "${length(var.london_dev_subnets)}"

  vpc_id = "${aws_vpc.dev.id}"
  cidr_block = "${var.london_dev_subnets[count.index]}"
  availability_zone = "${var.london_availability_zone_names[count.index]}"

  tags = {
    Name = "subnet-london-dev"
   }
  
}


# Route Tables
resource "aws_route_table" "dev" {
        provider = aws.london

  vpc_id = "${aws_vpc.dev.id}"
    tags = {
    Name = "rt-subnet-london-dev"
    }
  
  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  }

}

resource "aws_route_table_association" "dev" {
            provider = aws.london

  count = "${length(var.london_dev_subnets)}"

  subnet_id      = "${element(aws_subnet.dev.*.id, count.index)}"
  route_table_id = "${aws_route_table.dev.id}"
}

resource "aws_security_group" "london-dev" {
          provider = aws.london

  name        = "london-dev"
  description = "Default Dev Security Group"
  vpc_id      = "${aws_vpc.dev.id}"

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

### Create Transit Gateway Attachments

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-london-dev-attach" {
 ## subnets returns tuple so grab single element
       provider = aws.london

  subnet_ids         = "${aws_subnet.dev.*.id}"
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  vpc_id             = "${aws_vpc.dev.id}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

   tags = {
    Name = "vpc-london-dev"
    Terraform = "true"
    Environment = "dev"
  }

}

## TGW RT Associations

resource "aws_ec2_transit_gateway_route_table_association" "london-dev-tgw-rt-association" {

    #count = "${length(var.london_dev_subnets)}"


        provider = aws.london

  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-dev-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-dev-tgw-routing-table.id}"

}