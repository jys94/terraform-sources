output "ELB" {
  value = aws_elb.my-elb.dns_name
}
output "ELB-record" {
  value = aws_route53_record.asg-record.name
}