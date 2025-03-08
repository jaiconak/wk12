provider "aws" {
  region = "us-east-1"
}

# EX1 SIMILAR WAY
# resource "aws_instance" "ex1" {
#   ami = "ami-08b5b3a93ed654d19"
#   instance_type = "t3.small"

#   provisioner "local-exec" {
#     command = "echo ${aws_instance.server1.public_ip} > ip_address.txt"
#   }

#   provisioner "file" {
#     source = "ip_address.txt"
#     destination = "/home/ec2-user/ip_address.txt"
#   }
#   connection {
#     type = "ssh"
#     user = "ec2-user"
#     private_key = file("key.pem")
#     host = self.public_ip
#   }
  
#   provisioner "remote-exec" {
#     inline = [ 
#         "sudo yum update",
#         "sudo yum install -y httpd ",
#         "sudo echo Welcome!"
#      ]
#   }
# }


resource "aws_instance" "ex1" {
  ami = "ami-08b5b3a93ed654d19"
  instance_type = "t3.small"
  key_name = aws_key_pair.public.key_name
}
resource "tls_private_key" "terraform" {
  algorithm = "RSA"
  rsa_bits  = 2048
}
# Application of Private Key for AWS 1.PUBLIC (ABILITY TO SSH)
resource "aws_key_pair" "public" {
  key_name   = "terraformGenerated"
  public_key = tls_private_key.terraform.public_key_openssh
}

# Application of Private Key for AWS 1.PRIVATE (GENERATES PEM FILE LOCALLY)
resource "local_file" "private" {
  filename = "terraformGenerated.pem"
  content  = tls_private_key.terraform.private_key_pem
}


resource "null_resource" "nullEx" {
  provisioner "local-exec" {
    command = "echo ${aws_instance.ex1.public_ip} > ip_address.txt"
  }

  provisioner "file" {
    source = "ip_address.txt"   
    destination = "/home/ec2-user/ip_address.txt"
  }
  connection {
    type = "ssh"  #ssh -i terraformGenerated.pem ec2-user@aws_instance.ex1.public_ip
    user = "ec2-user"
    private_key = file("${local_file.private.filename}")
    host = aws_instance.ex1.public_ip
  }
  
  provisioner "remote-exec" {
    inline = [ 
        "sudo yum install -y httpd ",
        "sudo echo Welcome!"
     ]
  }
#   Needs EC2 AND KEY PAIR FIRST
  depends_on = [ aws_instance.ex1,local_file.private ]
}
 