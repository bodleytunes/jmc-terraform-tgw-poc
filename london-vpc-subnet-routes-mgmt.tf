


resource "aws_vpc" "mgmt" {
    provider = aws.london
  cidr_block = "${var.london_vpc_cidr_mgmt}"
  tags = {
    Name = "vpc-london-mgmt"
   }
}

## Subnets

resource "aws_subnet" "mgmt" {
        provider = aws.london

  count = "${length(var.london_mgmt_subnets)}"

  vpc_id = "${aws_vpc.mgmt.id}"
  cidr_block = "${var.london_mgmt_subnets[count.index]}"
  availability_zone = "${var.london_availability_zone_names[count.index]}"

  tags = {
    Name = "subnet-london-mgmt"
   }
  
}


# Route Tables
resource "aws_route_table" "mgmt" {
        provider = aws.london

  vpc_id = "${aws_vpc.mgmt.id}"
    tags = {
    Name = "rt-subnet-london-mgmt"
    }
  
  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  }

}

resource "aws_route_table_association" "mgmt" {
            provider = aws.london

  count = "${length(var.london_mgmt_subnets)}"

  subnet_id      = "${element(aws_subnet.mgmt.*.id, count.index)}"
  route_table_id = "${aws_route_table.mgmt.id}"
}

resource "aws_security_group" "london-mgmt" {
          provider = aws.london

  name        = "london-mgmt"
  description = "Default mgmt Security Group"
  vpc_id      = "${aws_vpc.mgmt.id}"

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

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-london-mgmt-attach" {
 ## subnets returns tuple so grab single element
       provider = aws.london

  subnet_ids         = "${aws_subnet.mgmt.*.id}"
  transit_gateway_id = "${aws_ec2_transit_gateway.TGW-LONDON.id}"
  vpc_id             = "${aws_vpc.mgmt.id}"

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false

   tags = {
    Name = "vpc-london-mgmt"
    Terraform = "true"
    Environment = "mgmt"
  }

}

## TGW RT Associations

resource "aws_ec2_transit_gateway_route_table_association" "london-mgmt-tgw-rt-association" {

        provider = aws.london


  transit_gateway_attachment_id  = "${aws_ec2_transit_gateway_vpc_attachment.tgw-london-mgmt-attach.id}"
  transit_gateway_route_table_id = "${aws_ec2_transit_gateway_route_table.london-mgmt-tgw-routing-table.id}"

}