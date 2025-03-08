provider "aws" {
    region = "us-east-1"
    profile = "default"
}

data "aws_ami" "dataAmi" {
#   executable_users = ["self"] for golden image
  most_recent      = true  #gives most recent image
#   name_regex       = "^myami-[0-9]{3}"  naming convention for image
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  } 

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "server2" {
  ami = data.aws_ami.dataAmi.id
  instance_type = "t2.micro"
}