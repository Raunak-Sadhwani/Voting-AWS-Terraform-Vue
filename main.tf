provider "aws" {
  s3_use_path_style = true
  region            = var.aws_region
  access_key        = "AKIAU6GD2NOWRJEM7FO6"
  secret_key        = "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"
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

resource "aws_s3_bucket_policy" "firstbucket_policy" {
  bucket = aws_s3_bucket.firstbucket.id

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




#creating s3 bucket 
resource "aws_s3_bucket" "firstbucket" {
  bucket = var.bucket_name
  tags = {
    Name = "Group10"
  }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.firstbucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# make bucket public 
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.firstbucket.id
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

  bucket = aws_s3_bucket.firstbucket.id
  acl    = var.bucket_acl
}


resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.firstbucket.id
  key          = "index.html"
  source       = "dist/index.html"
  content_type = "text/html"
}

resource "aws_s3_bucket_website_configuration" "exampleindex" {
  bucket = aws_s3_bucket.firstbucket.id
  index_document {
    suffix = "index.html"
  }
  depends_on = [aws_s3_bucket_acl.example]
}


# error page same as index page

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.firstbucket.id
  key          = "error.html"
  source       = "dist/index.html"
  content_type = "text/html"
}


# put the assets in the bucket
resource "aws_s3_object" "assets" {
  for_each     = fileset("dist/assets", "**/*")
  bucket       = aws_s3_bucket.firstbucket.id
  key          = "assets/${each.key}"
  source       = "dist/assets/${each.key}"
  content_type = local.mime_types[split(".", each.key)[length(split(".", each.key)) - 1]] # Get the file extension and lookup the MIME type
}

output "bucket_url" {
  value = aws_s3_bucket.firstbucket.website_endpoint
}


