# This bucket holds the terraform state and is used to upload artifacts

data "aws_s3_bucket" "lambda_bucket" {
  bucket = var.global_bucket
}
