

# resource "aws_dynamodb_table" "companies" {
#   name           = "companies"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "company_id"

#   attribute {
#     name = "company_id"
#     type = "S"
#   }

#   tags = {
#     Name = "CompaniesTable"
#   }
# }

# resource "aws_dynamodb_table" "users" {
#   name           = "users"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "user_id"
#   range_key      = "company_id"

#   attribute {
#     name = "user_id"
#     type = "S"
#   }

#   attribute {
#     name = "company_id"
#     type = "S"
#   }

#   global_secondary_index {
#     name               = "CompanyIndex"
#     hash_key           = "company_id"
#     projection_type    = "ALL"
#     write_capacity     = 1
#     read_capacity      = 1
#   }

#   tags = {
#     Name = "UsersTable"
#   }
# }

# resource "aws_dynamodb_table" "polls" {
#   name           = "polls"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "poll_id"
#   range_key      = "company_id"

#   attribute {
#     name = "poll_id"
#     type = "S"
#   }

#   attribute {
#     name = "company_id"
#     type = "S"
#   }

#   global_secondary_index {
#     name               = "CompanyIndex"
#     hash_key           = "company_id"
#     projection_type    = "ALL"
#     write_capacity     = 1
#     read_capacity      = 1
#   }

#   tags = {
#     Name = "PollsTable"
#   }
# }

# resource "aws_dynamodb_table" "votes" {
#   name           = "votes"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "vote_id"
#   range_key      = "poll_id"

#   attribute {
#     name = "vote_id"
#     type = "S"
#   }

#   attribute {
#     name = "poll_id"
#     type = "S"
#   }

#   global_secondary_index {
#     name               = "PollIndex"
#     hash_key           = "poll_id"
#     projection_type    = "ALL"
#     write_capacity     = 1
#     read_capacity      = 1
#   }

#   tags = {
#     Name = "VotesTable"
#   }
# }
