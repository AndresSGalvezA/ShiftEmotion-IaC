resource "aws_cloudwatch_log_group" "lambda_analysis" {

  name              = "/aws/lambda/${aws_lambda_function.analysis.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_getMetrics" {

  name              = "/aws/lambda/${aws_lambda_function.getMetrics.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_login" {

  name              = "/aws/lambda/${aws_lambda_function.login.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_recommendation" {

  name              = "/aws/lambda/${aws_lambda_function.recommendation.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_register" {

  name              = "/aws/lambda/${aws_lambda_function.register.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "lambda_users" {

  name              = "/aws/lambda/${aws_lambda_function.users.function_name}"
  retention_in_days = 30
}