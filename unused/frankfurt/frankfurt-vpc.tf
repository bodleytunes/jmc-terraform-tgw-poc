


data "aws_security_group" "default-frankfurt-dev" {
  provider = aws.frankfurt
  name   = "default"
  vpc_id = module.vpc-frankfurt-dev.vpc_id
}

data "aws_security_group" "default-frankfurt-prod" {
    provider = aws.frankfurt
  name   = "default"
  vpc_id = module.vpc-frankfurt-prod.vpc_id
}

data "aws_security_group" "default-frankfurt-mgmt" {
  provider = aws.frankfurt
  name   = "default"
  vpc_id = module.vpc-frankfurt-mgmt.vpc_id
}


module "vpc-frankfurt-dev" {
  source = "terraform-aws-modules/vpc/aws"

  providers = {
    aws = aws.frankfurt
  }

  name = "wizznet_dev"
  cidr = var.frankfurt_vpc_cidr_dev

  azs      = ["${var.frankfurt_availability_zone_names[0]}", "${var.frankfurt_availability_zone_names[1]}", "${var.frankfurt_availability_zone_names[2]}"]
  private_subnets = ["${var.frankfurt_dev_subnets[0]}", "${var.frankfurt_dev_subnets[1]}", "${var.frankfurt_dev_subnets[2]}"]

  enable_nat_gateway = false

  tags = {
    Name = "vpc-frankfurt-dev"
    Terraform = "true"
    Environment = "dev"
  }


}

module "vpc-frankfurt-prod" {
  source = "terraform-aws-modules/vpc/aws"

  providers = {
    aws = aws.frankfurt
  }

  name = "wizznet_prod"
  cidr = var.frankfurt_vpc_cidr_prod

  azs      = ["${var.frankfurt_availability_zone_names[0]}", "${var.frankfurt_availability_zone_names[1]}", "${var.frankfurt_availability_zone_names[2]}"]
  private_subnets = ["${var.frankfurt_prod_subnets[0]}", "${var.frankfurt_prod_subnets[1]}", "${var.frankfurt_prod_subnets[2]}"]

  enable_nat_gateway = false

  tags = {
    Name = "vpc-frankfurt-prod"
    Terraform = "true"
    Environment = "prod"
  }


}

module "vpc-frankfurt-mgmt" {
  source = "terraform-aws-modules/vpc/aws"

    providers = {
    aws = aws.frankfurt
  }

  name = "wizznet_mgmt"
  cidr =  var.frankfurt_vpc_cidr_mgmt

  azs      = ["${var.frankfurt_availability_zone_names[0]}", "${var.frankfurt_availability_zone_names[1]}", "${var.frankfurt_availability_zone_names[2]}"]
  private_subnets = ["${var.frankfurt_mgmt_subnets[0]}", "${var.frankfurt_mgmt_subnets[1]}", "${var.frankfurt_mgmt_subnets[2]}"]

  enable_nat_gateway = false

  tags = {
    Name = "vpc-frankfurt-mgmt"
    Terraform = "true"
    Environment = "mgmt"
  }
}