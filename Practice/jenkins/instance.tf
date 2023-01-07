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

resource "aws_instance" "jenkins-instance" {
  ami           = data.aws_ami.mzn2.id
  instance_type = "t2.small"
  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id
  # the security group
  vpc_security_group_ids = [aws_security_group.jenkins-securitygroup.id]
  # the public SSH key
  key_name = "Instance-Access-Key"
  # user data
  user_data = data.cloudinit_config.cloudinit-jenkins.rendered
  # iam instance profile
  iam_instance_profile = aws_iam_instance_profile.jenkins-role.name
}
resource "aws_ebs_volume" "jenkins-data" {
  availability_zone = "ap-northeast-2a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "jenkins-data"
  }
}
resource "aws_volume_attachment" "jenkins-data-attachment" {
  device_name  = var.INSTANCE_DEVICE_NAME
  volume_id    = aws_ebs_volume.jenkins-data.id
  instance_id  = aws_instance.jenkins-instance.id
  skip_destroy = true
}
resource "aws_instance" "app-instance" {
  count         = var.APP_INSTANCE_COUNT
  ami           = var.APP_INSTANCE_AMI
  instance_type = "t2.micro"
  # the VPC subnet
  subnet_id = aws_subnet.main-public-1.id
  # the security group
  vpc_security_group_ids = [aws_security_group.app-securitygroup.id]
  # the public SSH key
  key_name = var.KEY_PAIR_NAME
}