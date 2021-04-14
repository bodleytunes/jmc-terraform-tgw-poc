### Security Groups


data "aws_security_group" "default-dev" {
         provider = aws.london

  name   = "default"
  vpc_id = module.vpc-london-dev.vpc_id
}

data "aws_security_group" "default-prod" {
         provider = aws.london

  name   = "default"
  vpc_id = module.vpc-london-prod.vpc_id
}

data "aws_security_group" "default-mgmt" {
         provider = aws.london

  name   = "default"
  vpc_id = module.vpc-london-mgmt.vpc_id
}

data "aws_security_group" "default-internet" {
         provider = aws.london

  name   = "default"
  vpc_id = module.vpc-london-internet.vpc_id
}

### Create VPC

module "vpc-london-dev" {
  source = "terraform-aws-modules/vpc/aws"

  providers = {
    aws = aws.london
  }

  name = "wizznet_dev"
  cidr = "10.10.0.0/22"

  azs      = ["${var.london_availability_zone_names[0]}", "${var.london_availability_zone_names[1]}", "${var.london_availability_zone_names[2]}"]
  private_subnets = ["${var.london_dev_subnets[0]}", "${var.london_dev_subnets[1]}", "${var.london_dev_subnets[2]}"]

  enable_nat_gateway = false

  tags = {
    Name = "vpc-london-dev"
    Terraform = "true"
    Environment = "dev"
  }


}

module "vpc-london-prod" {
  source = "terraform-aws-modules/vpc/aws"

   providers = {
    aws = aws.london
  }


  name = "wizznet_prod"
  cidr = "10.20.0.0/22"

  azs      = ["${var.london_availability_zone_names[0]}", "${var.london_availability_zone_names[1]}", "${var.london_availability_zone_names[2]}"]
  private_subnets = ["${var.london_prod_subnets[0]}", "${var.london_prod_subnets[1]}", "${var.london_prod_subnets[2]}"]

  enable_nat_gateway = false

  tags = {
    Name = "vpc-london-prod"
    Terraform = "true"
    Environment = "prod"
  }


}

module "vpc-london-mgmt" {
  source = "terraform-aws-modules/vpc/aws"

   providers = {
    aws = aws.london
  }

  name = "wizznet_mgmt"
  cidr = "10.30.0.0/22"

  azs      = ["${var.london_availability_zone_names[0]}", "${var.london_availability_zone_names[1]}", "${var.london_availability_zone_names[2]}"]
  private_subnets = ["${var.london_mgmt_subnets[0]}", "${var.london_mgmt_subnets[1]}", "${var.london_mgmt_subnets[2]}"]

  enable_nat_gateway = false

  tags = {
    Name = "vpc-london-mgmt"
    Terraform = "true"
    Environment = "mgmt"
  }
}

module "vpc-london-internet" {
  source = "terraform-aws-modules/vpc/aws"

   providers = {
    aws = aws.london
  }

  name = "wizznet_internet"
  cidr = "10.166.6.0/23"

  azs      = ["${var.london_availability_zone_names[0]}"]
  private_subnets = ["${var.london_internet_subnets[0]}"]

  enable_nat_gateway = false

  tags = {
    Name = "vpc-london-internet"
    Terraform = "true"
    Environment = "internet"
  }
}