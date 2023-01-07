#resource "aws_route53_zone" "eksinfra-com" {
#  name = "eksinfra.com"
#}

resource "aws_route53_record" "asg-record" {
  zone_id = "Z08800912O9BRGRB4HCM"
  name    = "asg.eksinfra.com"
  type    = "A"

  alias {
    name                   = aws_elb.my-elb.dns_name
    zone_id                = aws_elb.my-elb.zone_id
    evaluate_target_health = true
  }
}