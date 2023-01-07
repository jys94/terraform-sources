resource "aws_sns_topic" "example-sns" {
 name         = "sg-sns"
 display_name = "example ASG SNS topic"
}
resource "aws_autoscaling_notification" "example-notify" {
 group_names = ["${aws_autoscaling_group.example-autoscaling.name}"]
 topic_arn     = "${aws_sns_topic.example-sns.arn}"
 notifications  = [
   "autoscaling:EC2_INSTANCE_LAUNCH",
   "autoscaling:EC2_INSTANCE_TERMINATE",
   "autoscaling:EC2_INSTANCE_LAUNCH_ERROR"
 ]
}
resource "aws_sns_topic_subscription" "sns_email_sub" {
  topic_arn              = aws_sns_topic.example-sns.arn
  protocol               = "email"
  endpoint               = "jys94520@gmail.com"
  endpoint_auto_confirms = true
}