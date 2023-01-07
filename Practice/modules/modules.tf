module "consul" {
  source   = "github.com/jys94/terraform-consul-module.git?ref=terraform-0.12"
  key_name = "Instance-Access-Key"
  key_path = var.PATH_TO_PRIVATE_KEY
  region   = var.AWS_REGION
  vpc_id   = aws_default_vpc.default.id
  subnets = {
    "0" = aws_default_subnet.default_az1.id
    "1" = aws_default_subnet.default_az3.id
  }
}
output "consul-output" {
  value = module.consul.server_address
}