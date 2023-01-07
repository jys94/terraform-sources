variable "AWS_REGION" {
  default = "ap-northeast-2"
}

variable "AMIS" {
  type = map(string)

  default = {
    us-east-1      = "ami-13be557e"
    us-west-2      = "ami-06b94666"
    eu-west-1      = "ami-844e0bf7"

    ap-northeast-1 = "ami-0bba69335379e17f8"
    ap-northeast-2 = "ami-035233c9da2fabf52"
    ap-southeast-1 = "ami-005835d578c62050d"
    ap-southeast-2 = "ami-051a81c2bd3e755db"
  }
}