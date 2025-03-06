module "ec2-server" {
  source        = "../"
  amiModule     = "ami-02a53b0d62d37a757"
  aws_region    = "us-east-1"
  profile       = "default"
  instance_type = "t2.micro"
}