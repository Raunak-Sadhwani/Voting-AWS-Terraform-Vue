# resource "aws_cloudwatch_log_group" "cloudfront_log_group" {
#   name              = "/aws/cloudfront/frontend"
#   retention_in_days = 14
# }

# resource "aws_cloudwatch_log_stream" "cloudfront_log_stream" {
#   name           = "cloudfront-log-stream"
#   log_group_name = aws_cloudwatch_log_group.cloudfront_log_group.name
# }

# resource "aws_iam_role" "lambda_execution_role" {
#   name = "lambda-execution-role"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_policy" "cloudwatch_logs_policy" {
#   name        = "cloudwatch-logs-policy"
#   description = "Allows CloudWatch Logs to invoke the Lambda function"
  
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow",
#         Action   = [
#           "lambda:InvokeFunction"
#         ],
#         Resource = aws_lambda_function.log_processor.arn
#       },
#       {
#         Effect   = "Allow",
#         Action   = [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents",
#           "logs:PutSubscriptionFilter"
#         ],
#         Resource = aws_cloudwatch_log_group.cloudfront_log_group.arn
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "cloudwatch_policy_attachment" {
#   role       = aws_iam_role.lambda_execution_role.name
<<<<<<< HEAD
#   policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
=======
#   policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
>>>>>>> 5a828b271b8a471840df7bc2381549ae225f6eba
# }

# resource "aws_lambda_function" "log_processor" {
#   filename         = "lambda_function/lambda_function_payload.zip"
<<<<<<< HEAD
#   function_name    = "cloudfront-log-processor"
=======
#   function_name    = "cloudwatch-log-processor"
>>>>>>> 5a828b271b8a471840df7bc2381549ae225f6eba
#   role             = aws_iam_role.lambda_execution_role.arn
#   handler          = "index.handler"
#   runtime          = "nodejs20.x"
#   source_code_hash = filebase64sha256("lambda_function/lambda_function_payload.zip")
# }

# resource "aws_cloudwatch_log_subscription_filter" "cloudfront_subscription_filter" {
<<<<<<< HEAD
#   name            = "cloudfront-subscription-filter"
#   log_group_name  = aws_cloudwatch_log_group.cloudfront_log_group.name
#   filter_pattern  = ""
#   destination_arn = aws_lambda_function.log_processor.arn
# }
=======
#   name            = "cloudwatch-subscription-filter"
#   log_group_name  = aws_cloudwatch_log_group.cloudfront_log_group.name
#   filter_pattern  = ""
#   destination_arn = aws_lambda_function.log_processor.arn

#   depends_on = [aws_lambda_function.log_processor]
# }
>>>>>>> 5a828b271b8a471840df7bc2381549ae225f6eba
