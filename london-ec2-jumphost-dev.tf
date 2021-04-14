### WIP todo
##	

##ubuntu-minimal/images-testing/hvm-ssd/ubuntu-bionic-daily-amd64-minimal-20190621 - ami-004aa2d035d3e8151

/* Instance Type	ECUs	vCPUs	Memory (GiB)	Instance Storage (GB)	EBS-Optimized Available	Network Performance
t2.nano	Variable	vcpu: 1	 ram: 0.5	EBS only	-	Low to Moderate */
# storage: Root	/dev/sda1	snap-0a61552cae4c0b278	
## gp2 / 8GB

## Sec Group

## known at create

## vpc: known at create

## subnet: known at create

## tags:
# london: jumphost


resource "aws_instance" "dev" {
            provider = aws.london

  ami           = "ami-004aa2d035d3e8151"
  instance_type = "t2.nano"
  #count = 1
  private_ip = "10.10.0.10"
  subnet_id  = "${aws_subnet.dev.0.id}"
}

