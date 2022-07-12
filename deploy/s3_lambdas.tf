resource "aws_s3_bucket" "s3_lambdas" {
  bucket        = "${var.app_name}-lambdas-src-code--${var.id_account}"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "ACL_s3_lambdas" {
  bucket = aws_s3_bucket.s3_lambdas.id
  acl    = "private"
}

resource "aws_s3_object" "analysis_zip" {
  bucket = aws_s3_bucket.s3_lambdas.id
  key    = "lambda_analysis.zip"
  source = data.archive_file.analysis_zip.output_path
  etag = filemd5(data.archive_file.analysis_zip.output_path)
}

resource "aws_s3_object" "getMetrics_zip" {
  bucket = aws_s3_bucket.s3_lambdas.id
  key    = "lambda_getMetrics.zip"
  source = data.archive_file.getMetrics_zip.output_path
  etag = filemd5(data.archive_file.getMetrics_zip.output_path)
}

resource "aws_s3_object" "login_zip" {
  bucket = aws_s3_bucket.s3_lambdas.id
  key    = "lambda_login.zip"
  source = data.archive_file.login_zip.output_path
  etag = filemd5(data.archive_file.register_zip.output_path)
}

resource "aws_s3_object" "recommendation_zip" {
  bucket = aws_s3_bucket.s3_lambdas.id
  key    = "lambda_recommendation.zip"
  source = data.archive_file.recommendation_zip.output_path
  etag = filemd5(data.archive_file.recommendation_zip.output_path)
}

resource "aws_s3_object" "register_zip" {
  bucket = aws_s3_bucket.s3_lambdas.id
  key    = "lambda_register.zip"
  source = data.archive_file.register_zip.output_path
  etag = filemd5(data.archive_file.register_zip.output_path)
}

resource "aws_s3_object" "users_zip" {
  bucket = aws_s3_bucket.s3_lambdas.id
  key    = "lambda_users.zip"
  source = data.archive_file.users_zip.output_path
  etag = filemd5(data.archive_file.users_zip.output_path)
}
