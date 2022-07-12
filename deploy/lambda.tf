resource "aws_lambda_function" "analysis" {
  function_name = "${var.app_name}-analysis"
  handler       = "lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.analysis_zip.key

  source_code_hash = data.archive_file.analysis_zip.output_base64sha256

  role = aws_iam_role.face_details_service.arn
}

resource "aws_lambda_function" "getMetrics" {
  function_name = "${var.app_name}-getMetrics"
  handler       = "lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.getMetrics_zip.key

  source_code_hash = data.archive_file.getMetrics_zip.output_base64sha256

  role = aws_iam_role.face_details_service.arn
}

resource "aws_lambda_function" "login" {
  function_name = "${var.app_name}-login"
  handler       = "lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.login_zip.key

  source_code_hash = data.archive_file.login_zip.output_base64sha256

  role = aws_iam_role.face_details_service.arn
}

resource "aws_lambda_function" "recommendation" {
  function_name = "${var.app_name}-recommendation"
  handler       = "lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.recommendation_zip.key

  source_code_hash = data.archive_file.recommendation_zip.output_base64sha256

  role = aws_iam_role.face_details_service.arn
}

resource "aws_lambda_function" "register" {
  function_name = "${var.app_name}-register"
  handler       = "lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.register_zip.key

  source_code_hash = data.archive_file.register_zip.output_base64sha256

  role = aws_iam_role.face_details_service.arn
}

resource "aws_lambda_function" "users" {
  function_name = "${var.app_name}-users"
  handler       = "lambda_handler"
  runtime       = var.runtime.python
  timeout       = 3
  memory_size   = 512
  architectures = ["arm64"]

  s3_bucket = aws_s3_bucket.s3_lambdas.id
  s3_key    = aws_s3_object.users_zip.key

  source_code_hash = data.archive_file.users_zip.output_base64sha256

  role = aws_iam_role.face_details_service.arn
}
