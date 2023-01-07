variable "AWS_REGION" {
  default = "ap-northeast-2"
}
variable "AMIS" {
  type = map(string)
  default = {
    us-east-1      = "ami-13be557e"
    us-west-2      = "ami-06b94666"
    ap-northeast-2 = "ami-035233c9da2fabf52"
  }
}