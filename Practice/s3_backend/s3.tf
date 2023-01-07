resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform-state-jys94"
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.terraform-state.id
  acl    = "private"
}