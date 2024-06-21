# resource "aws_dynamodb_table" "company" {
#   name           = "CompanyTable"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "company_id"

#   attribute {
#     name = "company_id"
#     type = "S"
#   }

#   attribute {
#     name = "user_id"
#     type = "S"
#   }

#   global_secondary_index {
#     name               = "UserIndex"
#     hash_key           = "user_id"
#     projection_type    = "ALL"
#   }

#   tags = {
#     Name = "CompanyTable"
#   }
# }

# resource "aws_iam_role" "dynamodb_access_role" {
#   name = "DynamoDBAccessRole"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = "sts:AssumeRole"
#         Effect = "Allow"
#         Principal = {
#           Service = "dynamodb.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_policy" "dynamodb_access_policy" {
#   name        = "DynamoDBAccessPolicy"
#   description = "A policy to allow access to the DynamoDB table"
  
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action = [
#           "dynamodb:BatchGetItem",
#           "dynamodb:GetItem",
#           "dynamodb:Query",
#           "dynamodb:Scan",
#           "dynamodb:ConditionCheckItem",
#           "dynamodb:PutItem",
#           "dynamodb:UpdateItem",
#           "dynamodb:DeleteItem"
#         ]
#         Effect   = "Allow"
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
#   role       = aws_iam_role.dynamodb_access_role.name
#   policy_arn = aws_iam_policy.dynamodb_access_policy.arn
# }

# resource "aws_dynamodb_table_item" "acme_inc" {
#   hash_key = aws_dynamodb_table.company.hash_key
#   table_name = aws_dynamodb_table.company.name

#   item = <<ITEM
# {
#   "company_id": {"S": "123456789"},
#   "name": {"S": "Acme Inc."},
#   "email": {"S": "info@acme.com"},
#   "users": {
#     "L": [
#       {"M": {"user_id": {"S": "user1"}, "user_name": {"S": "Alice"}, "user_email": {"S": "alice@example.com"}}},
#       {"M": {"user_id": {"S": "user2"}, "user_name": {"S": "Bob"}, "user_email": {"S": "bob@example.com"}}}
#     ]
#   }
# }
# ITEM

#   depends_on = [aws_dynamodb_table.company]
# }