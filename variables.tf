variable "amiModule" {
  description = "Amazon Machine Image"
  type        = string
  default     = "ami-02a53b0d62d37a757"
}

variable "instance_type" {
  default = "t2.small"
}

variable "aws_region" {}

variable "profile" {
  default = "default"
}