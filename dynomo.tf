# {
#   "company_id": "123456789",
#   "name": "Acme Inc.",
#   "email": "info@acme.com",
#   "users": [
#     {
#       "user_id": "user1",
#       "user_name": "Alice",
#       "user_email": "alice@example.com"
#     },
#     {
#       "user_id": "user2",
#       "user_name": "Bob",
#       "user_email": "bob@example.com"
#     }
#   ]
# }

# create me a dynamo db table as above
resource "aws_dynamodb_table" "mygrocery" {
  name           = "mygrocery"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "company_id"
  range_key      = "user_id"

  attribute {
    name = "company_id"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "name"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

    global_secondary_index {
        name               = "company_id-index"
        hash_key           = "company_id"
        range_key          = "user_id"
        write_capacity     = 5
        read_capacity      = 5
        projection_type    = "ALL"
    }

    tags = {
        Name = "mygrocery"
    }

}


