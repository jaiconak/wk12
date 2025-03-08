# Create ec2
resource "aws_instance" "ec2InstanceTestingTerraform" {
  ami             = "ami-04681163a08179f28"
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.name.key_name #This is for the public one
  security_groups = [aws_security_group.security_groups.name]
  user_data       = file("userData.sh")
  tags = {
    Name = "Terraform-Ec2"
  }
}
# Create EBS Volume
resource "aws_ebs_volume" "v1" {
  availability_zone = aws_instance.ec2InstanceTestingTerraform.availability_zone
  size              = 10
  tags = {
    Name = "devVolume"
    Team = "devOps"
  }
}

# Attach EBS Volume to Instance
resource "aws_volume_attachment" "name" {
  device_name = "/dev/sdb"
  volume_id   = aws_ebs_volume.v1.id
  instance_id = aws_instance.ec2InstanceTestingTerraform.id
}

# Creation of Private Key (GENERATES BOTH 1.PUBLIC AND 2.PRIVATE KEYS)
resource "tls_private_key" "terraform" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
# Application of Private Key for AWS 1.PUBLIC (ABILITY TO SSH)
resource "aws_key_pair" "name" {
  key_name   = "terraformGenerated"
  public_key = tls_private_key.terraform.public_key_openssh
}

# Application of Private Key for AWS 1.PRIVATE (GENERATES PEM FILE LOCALLY)
resource "local_file" "name" {
  filename = "terraformGenerated.pem"
  content  = tls_private_key.terraform.private_key_pem
}

# Security Group
resource "aws_security_group" "security_groups" {
  name        = "TerraformMade"
  description = "allow ingress 22 and 80"
  ingress {
    description = "allow ingress 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow ingress 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}