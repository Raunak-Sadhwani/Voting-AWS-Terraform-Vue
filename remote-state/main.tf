provider "aws" {
  s3_use_path_style = true
  region = "us-east-1"
}

data "aws_s3_bucket" "firstbucket" {
  bucket = "group10first"
}

