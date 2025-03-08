resource "aws_instance" "web" {
  ami                                  = "ami-08b5b3a93ed654d19"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1b"
  instance_type                        = "t2.micro"
  key_name                             = "ec2-keypair"
  monitoring                           = false
  subnet_id                            = "subnet-072ec5c111782559e"
  vpc_security_group_ids      = ["sg-04cd7565c09c7a766"]

  tags = {
    Name = "terraformLecture"
  }
}
