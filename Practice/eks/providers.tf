provider "aws" {
  region = "ap-northeast-2"
}

data "aws_region" "current" {
}

data "aws_availability_zones" "available" {
}

provider "http" {
}