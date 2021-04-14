#name	=	"dev"
frankfurt-region	=	"eu-central-1"
### BGP Autonomous System Number for Region
frankfurt-asn = "65002"

frankfurt_vpc_cidr_dev = "10.40.0.0/22"
frankfurt_vpc_cidr_prod = "10.50.0.0/22"
frankfurt_vpc_cidr_mgmt = "10.60.0.0/22"

frankfurt_availability_zone_names = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
]

frankfurt_dev_subnets = [
    "10.40.0.0/24",
    "10.40.1.0/24",
    "10.40.2.0/24"
]

frankfurt_prod_subnets = [
    "10.50.0.0/24",
    "10.50.1.0/24",
    "10.50.2.0/24"

]

frankfurt_mgmt_subnets = [
    "10.60.0.0/24",
    "10.60.1.0/24",
    "10.60.2.0/24"
]



jumphost_instance_type ="t2.nano"
jumphost_ami	=	"ami-035f7bc31ad78e3f2"