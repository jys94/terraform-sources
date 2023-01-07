variable "AWS_REGION" {
  default = "ap-northeast-2"
}
variable "AMIS" {
  type = map(string)
  default = {
    ap-northeast-2 = "ami-035233c9da2fabf52"
  }
}
variable "RDS_PASSWORD" {
}