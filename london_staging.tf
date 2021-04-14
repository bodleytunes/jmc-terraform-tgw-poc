#variable "name"				{}
#variable "region"			{}
#variable "vpc_cidr"			{}
#variable "azs"				{}
#variable "private_subnets"		{}
#variable "jumphost_instance_type"	{}
#variable "jumphost_ami"			{}
variable "london_availability_zone_names" {}
variable "london_dev_subnets" {}
variable "london_prod_subnets" {}
variable "london_mgmt_subnets" {}
variable "london_internet_subnets" {}
variable "london_vpn1_subnets" {}

variable "london_test_subnets" {}

#variable "london_vpc_cidr_dev" {}
#variable "london_vpc_cidr_prod" {}
#variable "london_vpc_cidr_mgmt" {}
variable "london-asn" {}
#variable "aws_access_key" {}
variable "london-region" {}

variable "london_vpc_cidr_dev" {} 
variable "london_vpc_cidr_test" {} 
variable "london_vpc_cidr_prod" {} 
variable "london_vpc_cidr_mgmt" {}
variable "london_vpc_cidr_vpn1" {}



