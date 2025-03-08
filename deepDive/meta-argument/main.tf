/*
count = 2
depends_on = 
for_each
lifecycle
*/

provider "aws" {
    region = "us-east-1"
    profile = "default"
}

# EX FOR DEPENDS ON
/*
resource "aws_instance" "ec2" {
    count = 2
    ami = "ami-08b5b3a93ed654d19"
    instance_type = "t2.micro"

    tags = {
      Name = "Jaico's Server ${count.index}"
    }

}

resource "aws_iam_user" "us1" {
     name = "cloudAdmin"
     depends_on = [ aws_instance.ec2 ]
}

output "ip" {
  value = aws_instance.ec2[*].public_ip
}
*/

variable "instanceSelect" {
    type = list(string)
  default = ["t2.micro","t3.small"]
}
resource "aws_instance" "ex3" {
  ami = "ami-08b5b3a93ed654d19"
  for_each = toset(var.instanceSelect)
  instance_type = each.key
}

# EX F0R_EACH 

# variable "info" {
#   type = map(object({
#     ami      = string
#     instance = string
#   }))
#   default = {
#     dev = {
#       ami      = "ami-08b5b3a93ed654d19"
#       instance = "t2.micro"
#     }
#     qa = {
#       ami      = "ami-08b5b3a93ed654d19wdsgf"
#       instance = "t2.micro"
#     }
#   }
# }

# resource "aws_instance" "ex4" {
#   for_each = var.info

#   ami           = each.value.ami
#   instance_type = each.value.instance

#   tags = {
#     Name = each.key
#   }
# }

# # EX FOR LIFECYCLE
# provider "aws" {
#   region = "us-east-1"
# }

# resource "aws_instance" "ex5" {
#   ami = "ami-08b5b3a93ed654d19"
#   instance_type = "t2.micro"
#   lifecycle {
#     create_before_destroy = true
#   }
# }


# # EX FOR ALIAS

# provider "aws" {
#     region = "us-east-1"
#     alias = "us1"  
# }

# resource "aws_instance" "ex5" {
#     ami = "ami-08b5b3a93ed654d19"
#     provider = aws.us1
#     instance_type = "t3.small"
  
# }


