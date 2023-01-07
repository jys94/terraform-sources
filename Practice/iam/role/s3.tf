resource "aws_s3_bucket" "b" {
  bucket = "mybucket-jys"
  tags = {
    Name = "mybucket-jys"
  }
}