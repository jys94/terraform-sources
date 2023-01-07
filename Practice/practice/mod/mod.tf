variable "name" {
}
resource "aws_instance" "my-instance" {
  name = "my-instance"
}
output "instance-name" {
  value = "hello"
}


data "aws_subnet" "my-external-subnet" {
  filter {
    name = "tag:Name"
    values = ["not-managed-by-terraform-subnet-name"]
  }
}
resource "aws_instance" "example" {
  ami   = data.aws_subnet.my-ubuntu.id
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.my-external-subnet.id
}