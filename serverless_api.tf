# IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM policy for Lambda to access DynamoDB
resource "aws_iam_policy" "lambda_policy" {
  name        = "lambda_policy"
  description = "Policy to allow Lambda to access DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:BatchGetItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan",
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

# Attach policy to role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Lambda function for companies
resource "aws_lambda_function" "voting_app_function" {
  function_name    = "voting_app_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  filename         = "lambda/lambda.zip"
  source_code_hash = filebase64sha256("lambda/lambda.zip")

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.company.name
    }
  }
}

# Lambda function for voters
resource "aws_lambda_function" "voter_app_function" {
  function_name    = "voter_app_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.handler"
  runtime          = "nodejs20.x"
  filename         = "lambda/lambda.zip"
  source_code_hash = filebase64sha256("lambda/lambda.zip")

  environment {
    variables = {
      TABLE_NAME = aws_dynamodb_table.voter.name
    }
  }
}

# API Gateway REST API
resource "aws_api_gateway_rest_api" "voting_api" {
  name        = "VotingAPI"
  description = "API for Voting App"
}

# API Gateway resource for companies
resource "aws_api_gateway_resource" "voting_resource" {
  rest_api_id = aws_api_gateway_rest_api.voting_api.id
  parent_id   = aws_api_gateway_rest_api.voting_api.root_resource_id
  path_part   = "voting"
}

# API Gateway resource for voters
resource "aws_api_gateway_resource" "voter_resource" {
  rest_api_id = aws_api_gateway_rest_api.voting_api.id
  parent_id   = aws_api_gateway_rest_api.voting_api.root_resource_id
  path_part   = "voter"
}

# POST method for companies
resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.voting_api.id
  resource_id   = aws_api_gateway_resource.voting_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# GET method for companies
resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.voting_api.id
  resource_id   = aws_api_gateway_resource.voting_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# DELETE method for companies
resource "aws_api_gateway_method" "delete_method" {
  rest_api_id   = aws_api_gateway_rest_api.voting_api.id
  resource_id   = aws_api_gateway_resource.voting_resource.id
  http_method   = "DELETE"
  authorization = "NONE"
}

# POST method for voters
resource "aws_api_gateway_method" "post_voter_method" {
  rest_api_id   = aws_api_gateway_rest_api.voting_api.id
  resource_id   = aws_api_gateway_resource.voter_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

# GET method for voters
resource "aws_api_gateway_method" "get_voter_method" {
  rest_api_id   = aws_api_gateway_rest_api.voting_api.id
  resource_id   = aws_api_gateway_resource.voter_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

# DELETE method for voters
resource "aws_api_gateway_method" "delete_voter_method" {
  rest_api_id   = aws_api_gateway_rest_api.voting_api.id
  resource_id   = aws_api_gateway_resource.voter_resource.id
  http_method   = "DELETE"
  authorization = "NONE"
}

# Lambda integration for companies
resource "aws_api_gateway_integration" "post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.voting_api.id
  resource_id             = aws_api_gateway_resource.voting_resource.id
  http_method             = aws_api_gateway_method.post_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.voting_app_function.invoke_arn
}

resource "aws_api_gateway_integration" "get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.voting_api.id
  resource_id             = aws_api_gateway_resource.voting_resource.id
  http_method             = aws_api_gateway_method.get_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.voting_app_function.invoke_arn
}

resource "aws_api_gateway_integration" "delete_integration" {
  rest_api_id             = aws_api_gateway_rest_api.voting_api.id
  resource_id             = aws_api_gateway_resource.voting_resource.id
  http_method             = aws_api_gateway_method.delete_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.voting_app_function.invoke_arn
}

# Lambda integration for voters
resource "aws_api_gateway_integration" "post_voter_integration" {
  rest_api_id             = aws_api_gateway_rest_api.voting_api.id
  resource_id             = aws_api_gateway_resource.voter_resource.id
  http_method             = aws_api_gateway_method.post_voter_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.voter_app_function.invoke_arn
}

resource "aws_api_gateway_integration" "get_voter_integration" {
  rest_api_id             = aws_api_gateway_rest_api.voting_api.id
  resource_id             = aws_api_gateway_resource.voter_resource.id
  http_method             = aws_api_gateway_method.get_voter_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.voter_app_function.invoke_arn
}

resource "aws_api_gateway_integration" "delete_voter_integration" {
  rest_api_id             = aws_api_gateway_rest_api.voting_api.id
  resource_id             = aws_api_gateway_resource.voter_resource.id
  http_method             = aws_api_gateway_method.delete_voter_method.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.voter_app_function.invoke_arn
}

# Lambda permission for API Gateway (companies)
resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.voting_app_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.voting_api.execution_arn}/*/*/*"
}

# Lambda permission for API Gateway (voters)
resource "aws_lambda_permission" "api_gateway_voter_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.voter_app_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.voting_api.execution_arn}/*/*/*"
}

# API Gateway deployment
resource "aws_api_gateway_deployment" "voting_api_deployment" {
  depends_on = [
    aws_api_gateway_integration.post_integration,
    aws_api_gateway_integration.get_integration,
    aws_api_gateway_integration.delete_integration,
    aws_api_gateway_integration.post_voter_integration,
    aws_api_gateway_integration.get_voter_integration,
    aws_api_gateway_integration.delete_voter_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.voting_api.id
  stage_name  = "prod"
}


resource "aws_api_gateway_method_response" "voting_method_response" {
  rest_api_id = aws_api_gateway_rest_api.voting_api.id
  resource_id = aws_api_gateway_resource.voting_resource.id
  http_method = aws_api_gateway_method.post_method.http_method
  status_code = 200


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_method_response" "voter_method_response" {
  rest_api_id = aws_api_gateway_rest_api.voting_api.id
  resource_id = aws_api_gateway_resource.voter_resource.id
  http_method = aws_api_gateway_method.post_voter_method.http_method
  status_code = 200


  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "voting_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.voting_api.id
  resource_id = aws_api_gateway_resource.voting_resource.id
  http_method = aws_api_gateway_method.post_method.http_method
  status_code = aws_api_gateway_method_response.voting_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,GET,DELETE,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [
    aws_api_gateway_method_response.voting_method_response,
    aws_api_gateway_integration.post_integration,
    aws_api_gateway_integration.get_integration,
    aws_api_gateway_integration.delete_integration
  ]
}

resource "aws_api_gateway_integration_response" "voter_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.voting_api.id
  resource_id = aws_api_gateway_resource.voter_resource.id
  http_method = aws_api_gateway_method.post_voter_method.http_method
  status_code = aws_api_gateway_method_response.voter_method_response.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,GET,DELETE,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [
    aws_api_gateway_method_response.voter_method_response,
    aws_api_gateway_integration.post_voter_integration,
    aws_api_gateway_integration.get_voter_integration,
    aws_api_gateway_integration.delete_voter_integration
  ]
}


# Output the API endpoint
output "api_endpoint" {
  value = "${aws_api_gateway_deployment.voting_api_deployment.invoke_url}/voting"
}

resource "local_file" "config_js" {
  content  = <<-EOF
    window.config = {
      API_ENDPOINT: "${aws_api_gateway_deployment.voting_api_deployment.invoke_url}",
      API_COGNITO: "${aws_api_gateway_deployment.votingx_deployment.invoke_url}"
    };
   export default window.config;
  EOF
  filename = "${path.module}/src/config.js"
}