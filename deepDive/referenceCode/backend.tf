terraform {
  backend "s3" {
    bucket         = "statefilejaico"
    key            = "wk7/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}