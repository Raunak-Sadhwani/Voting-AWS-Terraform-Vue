provider "aws" {
  s3_use_path_style = true
  region = var.aws_region
}

locals {
  mime_types = {
    css  = "text/css"
    js   = "application/javascript"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    png  = "image/png"
    gif  = "image/gif"
    html = "text/html"
    svg  = "image/svg+xml"
  }
}

#creating s3 bucket 
data "aws_s3_bucket" "firstbucket" {
  bucket = var.bucket_name 
  
}

# website {
#     index_document = "index.html"
#   }

resource "aws_s3_bucket_website_configuration" "firstbucket_website" {
  bucket = data.aws_s3_bucket.firstbucket.id
  #index_document = "dist/index.html"
  #error_document = "dist/index.html"

  index_document {
    suffix = "dist/index.html"
  }

  error_document {
    key = "dist/error.html"
  }
}


resource "aws_s3_bucket_policy" "firstbucket_policy" {
  bucket = data.aws_s3_bucket.firstbucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "Statement1"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "arn:aws:s3:::group10first/*"
      }
    ]
  })
}





resource "aws_s3_bucket_versioning" "example" {
    bucket = data.aws_s3_bucket.firstbucket.id
    versioning_configuration {
      status = "Enabled" 
    }
}
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = data.aws_s3_bucket.firstbucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# make bucket public 
resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = data.aws_s3_bucket.firstbucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# make bucket acl public
resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = data.aws_s3_bucket.firstbucket.id
  acl    = var.bucket_acl
}



resource "aws_s3_object" "index" {
  bucket       = data.aws_s3_bucket.firstbucket.id
  key          = "index.html"
  source       = "dist/index.html"
  content_type = "text/html"
}


# put the assets in the bucket
resource "aws_s3_object" "assets" {
  for_each     = fileset("dist/assets", "**/*")
  bucket       = data.aws_s3_bucket.firstbucket.id
  key          = "assets/${each.key}"
  source       = "dist/assets/${each.key}"
  content_type = local.mime_types[split(".", each.key)[length(split(".", each.key)) - 1]] # Get the file extension and lookup the MIME type
}



output "bucket_url" {
  value = data.aws_s3_bucket.firstbucket.website_endpoint
}



