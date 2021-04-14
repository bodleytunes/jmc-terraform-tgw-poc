provider "aws" {
  alias = "london"
	region = var.london-region
 	access_key = "${var.aws_access_key}"
 	secret_key = "${var.aws_secret_key}"
} 

provider "aws" {
  alias = "frankfurt"
	region = var.frankfurt-region
 	access_key = "${var.aws_access_key}"
 	secret_key = "${var.aws_secret_key}"
} 

