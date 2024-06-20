terraform {
  backend "s3" {
    bucket = "group10first"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}