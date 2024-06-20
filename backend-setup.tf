provider "aws" {
  s3_use_path_style = true
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "group10first"
  tags = {
    Name = "Group10"
  }
}

# resource "aws_dynamodb_table" "terraform_lock" {
#   name         = "terraform-lock"
#   billing_mode = "PAY_PER_REQUEST"
#   hash_key     = "LockID"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
