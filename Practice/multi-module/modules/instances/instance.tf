variable "ENV" { }
variable "INSTANCE_TYPE" { default = "t2.micro" }
variable "PUBLIC_SUBNETS" { type = list }
variable "VPC_ID" { }
data "aws_ami" "mzn2" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["137112412989"] # Canonical
}
resource "aws_instance" "instance" {
  ami           = data.aws_ami.mzn2.id
  instance_type = var.INSTANCE_TYPE
  subnet_id = element(var.PUBLIC_SUBNETS, 0)                 # the VPC subnet
  vpc_security_group_ids = [aws_security_group.allow-ssh.id] # the security group
  key_name = "Instance-Access-Key"                           # the public SSH key
  tags = {
    Name         = "instance-${var.ENV}"
    Environmnent = var.ENV
  }
}
resource "aws_security_group" "allow-ssh" {
  vpc_id      = var.VPC_ID
  name        = "allow-ssh-${var.ENV}"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name         = "allow-ssh"
    Environmnent = var.ENV
  }
}