# Create Cognito User Pool
resource "aws_cognito_user_pool" "votingx_user_pool" {
  name = "votingx-user-pool"

  password_policy {
    minimum_length    = 6
    require_lowercase = false
    require_uppercase = false
    require_numbers   = false
    require_symbols   = false
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }
}

# Create Cognito User Pool Client
resource "aws_cognito_user_pool_client" "votingx_user_pool_client" {
  name                                 = "votingx-user-pool-client"
  user_pool_id                         = aws_cognito_user_pool.votingx_user_pool.id
  generate_secret                      = false
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["aws.cognito.signin.user.admin"]
  supported_identity_providers         = ["COGNITO"]
  explicit_auth_flows                  = ["ADMIN_NO_SRP_AUTH", "USER_PASSWORD_AUTH"]
  callback_urls                        = ["https://example.com"]
  prevent_user_existence_errors        = "ENABLED"
}

# Output the User Pool ID and Client ID
output "user_pool_id" {
  value = aws_cognito_user_pool.votingx_user_pool.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.votingx_user_pool_client.id
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_rolex" {
  name = "lambda_rolex"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_rolex.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action = [
          "cognito-idp:AdminInitiateAuth",
          "cognito-idp:GetUser",
          "cognito-idp:ListUsers",
          "cognito-idp:ListUserPools"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}


# Lambda Function
resource "aws_lambda_function" "votingx_lambda" {
  runtime          = "nodejs20.x"
  filename         = "cognito/cognito.zip"
  source_code_hash = filebase64sha256("cognito/cognito.zip")
  function_name    = "votingx_lambda"
  role             = aws_iam_role.lambda_rolex.arn
  handler          = "index.handler"
  timeout          = 30

  environment {
    variables = {
      USER_POOL_ID = aws_cognito_user_pool.votingx_user_pool.id
      CLIENT_ID    = aws_cognito_user_pool_client.votingx_user_pool_client.id
    }
  }
}

# API Gateway
resource "aws_api_gateway_rest_api" "votingx_api" {
  name        = "votingx-api"
  description = "Voting API"
}

resource "aws_api_gateway_resource" "login" {
  rest_api_id = aws_api_gateway_rest_api.votingx_api.id
  parent_id   = aws_api_gateway_rest_api.votingx_api.root_resource_id
  path_part   = "login"
}

resource "aws_api_gateway_method" "post_methodx" {
  rest_api_id   = aws_api_gateway_rest_api.votingx_api.id
  resource_id   = aws_api_gateway_resource.login.id
  http_method   = "POST"
  authorization = "NONE"
  request_parameters = {
    "method.request.header.Access-Control-Allow-Headers" = true
    "method.request.header.Access-Control-Allow-Methods" = true
    "method.request.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = aws_api_gateway_rest_api.votingx_api.id
  resource_id             = aws_api_gateway_resource.login.id
  http_method             = aws_api_gateway_method.post_methodx.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.votingx_lambda.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.votingx_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.votingx_api.execution_arn}/*/*"
}


resource "aws_api_gateway_deployment" "votingx_deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.votingx_api.id
  stage_name  = "prod"
}

resource "aws_api_gateway_method_response" "votingx_method_response" {
  rest_api_id = aws_api_gateway_rest_api.votingx_api.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.post_methodx.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "votingx_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.votingx_api.id
  resource_id = aws_api_gateway_resource.login.id
  http_method = aws_api_gateway_method.post_methodx.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  depends_on = [
    aws_api_gateway_method_response.votingx_method_response,
    aws_api_gateway_integration.lambda_integration,
  ]
}


# test user
resource "aws_cognito_user" "votingx_user" {
  username     = "test"
  user_pool_id = aws_cognito_user_pool.votingx_user_pool.id
  password     = "12345678"
}

output "api_endpoint_login" {
  value = "${aws_api_gateway_deployment.votingx_deployment.invoke_url}/login"
}