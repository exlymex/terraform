locals {
  env = "local"
}
resource "aws_s3_bucket" "this" {
  bucket = "my-tf-test-bucket-lpnu-030923"

    tags = {
    Name        = "My bucket"
    Environment = local.env
  }
}
