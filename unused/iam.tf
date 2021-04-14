# CONFIGURATION AND PARAMETERS
/* 

variable "keybase" {
  description = "Enter the keybase profile to encrypt the secret_key (to decrypt: terraform output secret_key | base64 --decode | keybase pgp decrypt)"
}



data "aws_caller_identity" "current" {}

# RESOURCES

resource "aws_iam_user" "wizznetadmin" {
  name = "wizznetadmin"
}

resource "aws_iam_access_key" "wizznetadmin" {
  user = "${aws_iam_user.wizznetadmin.name}"
  pgp_key = "keybase:${var.keybase}"
}

resource "aws_iam_user_policy" "wizznetadmin_assume_role" {
  name = "wizznetadmin"
  user = "${aws_iam_user.wizznetadmin.name}"

  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "sts:Assume*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "S3AccessRole" {
  name = "WizznetadminS3Access"
  assume_role_policy = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "S3AccessPolicy" {
  name = "WizznetadminS3AccessPolicy"
  role = "${aws_iam_role.S3AccessRole.id}"
  policy = <<EOF
{
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

# OUTPUT

output "role_arn" {
  value = "${aws_iam_role.S3AccessRole.arn}"
}
output "access_key" {
  value = "${aws_iam_access_key.wizznetadmin.id}"
}
output "secret_key" {
  value = "${aws_iam_access_key.wizznetadmin.encrypted_secret}"
}
 */