variable "aws_region" {
  description = "The AWS region to deploy to"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default = "group10first"
}

variable "bucket_acl" {
  description = "The acl of the S3 bucket"
  type        = string
  default = "public-read"
}

variable "account_id" {
  default = "100666514632"
}