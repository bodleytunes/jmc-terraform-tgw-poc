
/* 
variable "subnet_cidrs_test" {
  description = "Subnet CIDRs for test"
  # this could be further simplified / computed using cidrsubnet() etc.
  # https://www.terraform.io/docs/configuration/interpolation.html#cidrsubnet-iprange-newbits-netnum-
  default = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  type = "list"
}

## VPC

variable "vpc_cidr_test" {
  default = "10.0.0.0/16"
}
 */

resource "aws_vpc" "test" {
    provider = aws.london
  cidr_block = "${var.london_vpc_cidr_test}"
  tags = {
    Name = "vpc-london-test"
   }
}

## Subnets

resource "aws_subnet" "test" {
        provider = aws.london

  count = "${length(var.london_test_subnets)}"

  vpc_id = "${aws_vpc.test.id}"
  cidr_block = "${var.london_test_subnets[count.index]}"
  availability_zone = "${var.london_availability_zone_names[count.index]}"
   tags = {
    Name = "subnet-london-test"
   }
}


# Route Tables
resource "aws_route_table" "test" {
        provider = aws.london

  vpc_id = "${aws_vpc.test.id}"
      tags = {
    Name = "rt-subnet-london-test"
    }


}

resource "aws_route_table_association" "test" {
            provider = aws.london
  count = "${length(var.london_test_subnets)}"

  subnet_id      = "${element(aws_subnet.test.*.id, count.index)}"
  route_table_id = "${aws_route_table.test.id}"
}

resource "aws_security_group" "london-test" {
          provider = aws.london

  name        = "london-test"
  description = "Default Security Group"
  vpc_id      = "${aws_vpc.test.id}"

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

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-london-test-attach" {
 ## subnets returns tuple so grab single element
       provider = aws.london

  subnet_ids         = "${aws_subnet.test.*.id}"
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  vpc_id             = "${aws_vpc.test.id}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

   tags = {
    Name = "vpc-london-test"
    Terraform = "true"
    Environment = "test"
  }

}

## TGW RT Associations

resource "aws_ec2_transit_gateway_route_table_association" "london-test-tgw-rt-association" {



        provider = aws.london

  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-test-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-test-tgw-routing-table.id}"

}