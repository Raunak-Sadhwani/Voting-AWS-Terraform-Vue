resource "aws_dynamodb_table" "company" {
  name           = "CompanyTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "company_id"

  attribute {
    name = "company_id"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  global_secondary_index {
    name               = "UserIndex"
    hash_key           = "user_id"
    projection_type    = "ALL"
  }

  tags = {
    Name = "CompanyTable"
  }
}




resource "aws_dynamodb_table" "voter" {
  name           = "voterTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "voter_id"

  attribute {
    name = "voter_id"
    type = "S"
  }

  global_secondary_index {
    name               = "voterIndex"
    hash_key           = "voter_id"
    projection_type    = "ALL"
  }

  tags = {
    Name = "voterTable"
  }
}

resource "aws_iam_role" "dynamodb_access_role" {
  name = "DynamoDBAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "dynamodb.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "dynamodb_access_policy" {
  name        = "DynamoDBAccessPolicy"
  description = "A policy to allow access to the DynamoDB table"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:BatchGetItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:ConditionCheckItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
  role       = aws_iam_role.dynamodb_access_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}


resource "aws_dynamodb_table_item" "acme_inc" {
  hash_key   = aws_dynamodb_table.company.hash_key
  table_name = aws_dynamodb_table.company.name

  item = <<ITEM
{
  "company_id": {"S": "1234567890"},
  "name": {"S": "Innovative Solutions Corp."},
  "email": {"S": "info@acme.com"},
  "company_descriptions": {"S": "At Innovative Solutions Corp., we believe in the power of technology to transform businesses and improve lives. Our mission is to empower organizations with the tools they need to succeed in a rapidly changing world. Through continuous research and development, we aim to stay at the forefront of technological advancements, delivering products that set new standards in quality and performance."},

  "users": {
    "L": [
      
      {"M": {
        "user_id": {"S": "user1"},
        "user_name": {"S": "John Doe"},
        "user_descriptions": {"S": "John Doe is a seasoned software engineer with extensive experience in artificial intelligence and machine learning. He has a proven track record of developing high-performance applications and is passionate about leveraging technology to solve real-world problems."},
        "user_manifesto": {"S": "1. Drive innovation in technology.\n2. Foster a collaborative environment.\n3. Promote sustainable practices.\n4. Ensure data security and privacy.\n5. Deliver exceptional user experiences."},
        "user_votes": {"S": "150"}
      }},
      {"M": {
        "user_id": {"S": "user2"},

        "user_name": {"S": "Jane Smith"},
        "user_descriptions": {"S": "Jane Smith is an expert in renewable energy with a deep understanding of environmental science. She has led multiple projects aimed at reducing greenhouse gas emissions and is a strong advocate for clean energy policies."},
        "user_manifesto": {"S": "1. Advocate for renewable energy.\n2. Support environmental sustainability.\n3. Reduce carbon footprint.\n4. Innovate in clean energy technology.\n5. Promote energy efficiency."},
        "user_votes": {"S": "200"}
      }},
      {"M": {
        "user_id": {"S": "user3"},
        "user_name": {"S": "Emily Johnson"},
        "user_descriptions": {"S": "Emily Johnson is a healthcare professional with a strong background in medical technology. She has a passion for improving healthcare systems and has implemented various tech-driven solutions to enhance patient care and operational efficiency."},
        "user_manifesto": {"S": "1. Innovate healthcare technology.\n2. Improve patient outcomes.\n3. Enhance operational efficiency.\n4. Promote patient-centered care.\n5. Ensure healthcare accessibility."},
        "user_votes": {"S": "120"}
      }}
    ]
  }
}
ITEM
  depends_on = [aws_dynamodb_table.company]
}

resource "aws_dynamodb_table_item" "voter1" {
  hash_key   = aws_dynamodb_table.voter.hash_key
  table_name = aws_dynamodb_table.voter.name

  item = <<ITEM
{
  "voter_id": {"S": "voter1"},
  "voter_name": {"S": "Alice Johnson"},
  "voter_email": {"S": "alice.johnson@example.com"},
  "voted_for_id": {"S": "candidate1"}
}
ITEM

  depends_on = [aws_dynamodb_table.voter]
}

resource "aws_dynamodb_table_item" "voter2" {
  hash_key   = aws_dynamodb_table.voter.hash_key
  table_name = aws_dynamodb_table.voter.name

  item = <<ITEM
{
  "voter_id": {"S": "voter2"},
  "voter_name": {"S": "Bob Smith"},
  "voter_email": {"S": "bob.smith@example.com"},
  "voted_for_id": {"S": "candidate2"}
}
ITEM

  depends_on = [aws_dynamodb_table.voter]
}

resource "aws_dynamodb_table_item" "voter3" {
  hash_key   = aws_dynamodb_table.voter.hash_key
  table_name = aws_dynamodb_table.voter.name

  item = <<ITEM
{
  "voter_id": {"S": "voter3"},
  "voter_name": {"S": "Charlie Brown"},
  "voter_email": {"S": "charlie.brown@example.com"},
  "voted_for_id": {"S": "candidate1"}
}
ITEM

  depends_on = [aws_dynamodb_table.voter]
}

resource "aws_dynamodb_table_item" "voter4" {
  hash_key   = aws_dynamodb_table.voter.hash_key
  table_name = aws_dynamodb_table.voter.name

  item = <<ITEM
{
  "voter_id": {"S": "voter4"},
  "voter_name": {"S": "Dana White"},
  "voter_email": {"S": "dana.white@example.com"},
  "voted_for_id": {"S": "candidate3"}
}
ITEM

  depends_on = [aws_dynamodb_table.voter]
}


