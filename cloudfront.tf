# resource "aws_s3_bucket" "cloudfront_logs" {
#   bucket = var.bucket_name
# #     grant {
# #     type        = "Group"
# #     uri         = "http://acs.amazonaws.com/groups/s3/LogDelivery"
# #     permissions = ["WRITE"]
# #   }
# }

# resource "aws_cloudfront_distribution" "frontend_distribution" {
#   origin {
#     domain_name = aws_s3_bucket.firstbucket.bucket_regional_domain_name
#     origin_id   = "S3-frontend-bucket"
#   }

#   enabled             = true
#   is_ipv6_enabled     = true
#   comment             = "CloudFront distribution for frontend"
#   default_root_object = "index.html"

#   default_cache_behavior {
#     allowed_methods  = ["GET", "HEAD"]
#     cached_methods   = ["GET", "HEAD"]
#     target_origin_id = "S3-frontend-bucket"

#     forwarded_values {
#       query_string = false
#       cookies {
#         forward = "none"
#       }
#     }

#     viewer_protocol_policy = "redirect-to-https"
#   }

#   restrictions {
#     geo_restriction {
#       restriction_type = "none"
#     }
#   }

#   logging_config {
#     bucket = aws_s3_bucket.cloudfront_logs.bucket_domain_name
#     include_cookies = false
#     prefix = "frontend/"
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }

# output "cloudfront_url" {
#   value = aws_cloudfront_distribution.frontend_distribution.domain_name
# }
