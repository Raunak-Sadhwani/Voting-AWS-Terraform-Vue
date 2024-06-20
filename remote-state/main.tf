provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "firstbucket" {
  bucket = "group10first"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "example" {
    bucket = aws_s3_bucket.firstbucket.id
    versioning_configuration {
      status = "Enabled"
    }
}