terraform {
  backend "s3" {
    bucket = "terraform-state-jys94"
    key    = "terraform/demo4"
    region = "ap-northeast-2"
  }
}