# resource "aws_key_pair" "mykey" {
#   key_name   = "mykey"
#   public_key = file(var.PATH_TO_PUBLIC_KEY)
# }
resource "aws_instance" "example" {
  ami                         = var.AMIS[var.AWS_REGION]
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-02dd0dd07bbc9cc7a"
  associate_public_ip_address = true
  key_name                    = "mykey"
  provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo sed -i -e 's/\r$//' /tmp/script.sh", # Remove the spurious CR(Carriage Return) characters.
      "sudo /tmp/script.sh",
    ]
  }
  connection {
    host        = coalesce(self.public_ip, self.private_ip)
    user        = var.INSTANCE_USERNAME
    private_key = file(var.PATH_TO_PRIVATE_KEY)
  }
}