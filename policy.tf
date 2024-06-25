
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
