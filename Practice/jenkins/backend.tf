terraform {
 backend "s3" {
   bucket = "terraform-state-wkqkdgtt"
   key    = "terraform.tfstate"
   region = "ap-northeast-2"
 }
}