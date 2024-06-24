

resource "aws_lambda_function" "verify_token_lambda" {
  runtime          = "nodejs20.x"
  filename         = "verifytoken/verifytoken.zip"
  source_code_hash = filebase64sha256("verifytoken/verifytoken.zip")

  function_name = "verify_token_lambda"
  role          = aws_iam_role.lambda_rolex.arn
  handler       = "index.handler"
  timeout       = 30

  environment {
    variables = {
      USER_POOL_ID = aws_cognito_user_pool.votingx_user_pool.id
    }
  }
}

# Create a new API Gateway resource for token verification
resource "aws_api_gateway_resource" "verify_token" {
  rest_api_id = aws_api_gateway_rest_api.votingx_api.id
  parent_id   = aws_api_gateway_rest_api.votingx_api.root_resource_id
  path_part   = "verify-token"
}

# Create a new POST method for the verify-token resource
resource "aws_api_gateway_method" "post_verify_token" {
  rest_api_id   = aws_api_gateway_rest_api.votingx_api.id
  resource_id   = aws_api_gateway_resource.verify_token.id
  http_method   = "POST"
  authorization = "NONE"
  request_parameters = {
    "method.request.header.Access-Control-Allow-Headers" = true
    "method.request.header.Access-Control-Allow-Methods" = true
    "method.request.header.Access-Control-Allow-Origin"  = true
  }
}

# Integrate the Lambda function with the API Gateway method
resource "aws_api_gateway_integration" "verify_token_integration" {
  rest_api_id             = aws_api_gateway_rest_api.votingx_api.id
  resource_id             = aws_api_gateway_resource.verify_token.id
  http_method             = aws_api_gateway_method.post_verify_token.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.verify_token_lambda.invoke_arn
}

# Grant API Gateway permission to invoke the Lambda function
resource "aws_lambda_permission" "apigw_verify_token_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.verify_token_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.votingx_api.execution_arn}/*/*"
}

# Deploy the new API Gateway resource
resource "aws_api_gateway_deployment" "votingx_verify_deployment" {
  depends_on = [
    aws_api_gateway_integration.verify_token_integration,
  ]

  rest_api_id = aws_api_gateway_rest_api.votingx_api.id
  stage_name  = "prod"
}

# cors post 
resource "aws_api_gateway_method_response" "votingx_verify_method_response" {
  rest_api_id = aws_api_gateway_rest_api.votingx_api.id
  resource_id = aws_api_gateway_resource.verify_token.id
  http_method = aws_api_gateway_method.post_verify_token.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}


resource "aws_api_gateway_integration_response" "votingx_verify_integration_response" {
  rest_api_id = aws_api_gateway_rest_api.votingx_api.id
  resource_id = aws_api_gateway_resource.verify_token.id
  http_method = aws_api_gateway_method.post_verify_token.http_method
  status_code = 200

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }

  depends_on = [
    aws_api_gateway_method_response.votingx_method_response,
    aws_api_gateway_integration.verify_token_integration,
  ]
}

# Output the new API endpoint
output "verify_token_api_endpoint" {
  value = "${aws_api_gateway_deployment.votingx_verify_deployment.invoke_url}/verify-token"
}
