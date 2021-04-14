#name	=	"dev"
#region	=	"eu-west-2"
london-region	=	"eu-west-2"

#vpc_cidr	=	"10.10.0.0/22"
london-asn = "65001"
london_vpc_cidr_dev = "10.10.0.0/22"
london_vpc_cidr_prod = "10.20.0.0/22"
london_vpc_cidr_mgmt = "10.30.0.0/22"
london_vpc_cidr_test = "10.0.0.0/16"
london_vpc_cidr_vpn1 = "10.254.255.0/25"



london_availability_zone_names = [
    "eu-west-2a",
    "eu-west-2b",
    "eu-west-2c"
]

london_dev_subnets = [
    "10.10.0.0/24",
    "10.10.1.0/24",
    "10.10.2.0/24"
]

london_prod_subnets = [
    "10.20.0.0/24",
    "10.20.1.0/24",
    "10.20.2.0/24"

]

london_mgmt_subnets = [
    "10.30.0.0/24",
    "10.30.1.0/24",
    "10.30.2.0/24"
]

london_test_subnets = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24"
]

london_vpn1_subnets = [
    "10.254.255.0/27",
    "10.254.255.32/27"
]

london_internet_subnets = [
    "10.166.6.0/25"
]


jumphost_instance_type ="t2.nano"
jumphost_ami	=	"ami-035f7bc31ad78e3f2"
