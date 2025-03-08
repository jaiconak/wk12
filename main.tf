resource "aws_instance" "jaicoWebserver" {
  ami           = var.amiModule
  instance_type = var.instance_type

  tags = {
    Name = "jaicoWebserver"
  }
}