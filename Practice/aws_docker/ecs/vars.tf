variable "AWS_REGION" {
  default = "ap-northeast-2"
}
variable "KEY_PAIR_NAME" {
  default = "Instance-Access-Key"
}
variable "ECS_INSTANCE_TYPE" {
  default = "t2.micro"
}
variable "ECS_AMIS" {
  type = map(string)
  default = {
    us-east-1      = "ami-13be557e"
    us-west-2      = "ami-06b94666"
    eu-west-1      = "ami-844e0bf7"

    ap-northeast-1 = "ami-0bba69335379e17f8"
    ap-southeast-2 = "ami-051a81c2bd3e755db"

    ap-northeast-2 = "ami-036e92dacf8a46be6"
  }
}