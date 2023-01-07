resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  subnet_id     = "subnet-02dd0dd07bbc9cc7a"
  associate_public_ip_address = true
  key_name      = "Instance-Access-Key"
}