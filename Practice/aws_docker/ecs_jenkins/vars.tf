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
    ap-northeast-2 = "ami-036e92dacf8a46be6"
  }
}
# Full List: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html

variable "AMIS" {
  type = map(string)
  default = {
    ap-northeast-2 = "ami-035233c9da2fabf52"
  }
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}