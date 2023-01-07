resource "aws_instance" "example" {
  ami                         = var.AMIS[var.AWS_REGION]
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-02dd0dd07bbc9cc7a"
  associate_public_ip_address = true
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }
}
output "ip" {
  value = aws_instance.example.public_ip
}