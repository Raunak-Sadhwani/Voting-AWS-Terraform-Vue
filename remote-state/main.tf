provider "aws" {
  region = "us-east-1"
}

data "aws_s3_bucket" "firstbucketx" {
  bucket = "group10first"
}

resource "aws_s3_bucket_versioning" "example" {
    bucket = aws_s3_bucket.firstbucketx.id
    versioning_configuration {
      status = "Enabled"
    }
}