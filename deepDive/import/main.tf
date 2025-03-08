provider "aws" {
  region = "us-east-1"
  profile = "default"
}

import {
  to = aws_instance.web
  id = "i-03bd88173ce2dad52"
}


# import {
#   to = aws_key_pair.deployer
#   id = "windowsKeyPairPersonal"
# }