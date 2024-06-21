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

variable "AWS_ACCOUNT_ID" {
  
  type        = string
  default     = "339713092525"
}
variable "function_upload_name_lambda" {
  default = "mygrocery_put_object"
}

variable "function_upload_handler_lambda" {
  default = "mygrocery_put_object.lambda_handler"
}

variable "function_get_name_lambda" {
  default = "mygrocery_get_object"
}

variable "function_get_handler_lambda" {
  default = "mygrocery_get_object.lambda_handler"
}


variable "runtime_version" {
  default = "python3.8"
}


variable "api_gateway_name" {
  default = "mygrocery-web-put-api"
}

variable "api_gateway_stage_name" {
  default = "Gaayu"
}
