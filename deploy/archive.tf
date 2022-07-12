data "archive_file" "analysis_zip" {

  type        = "zip"
  source_dir  = "../functions/analysis"
  output_path = "../zipFiles/lambda_analysis.zip"
}

data "archive_file" "getMetrics_zip" {

  type        = "zip"
  source_dir  = "../functions/getMetrics"
  output_path = "../zipFiles/lambda_getMetrics.zip"
}

data "archive_file" "login_zip" {

  type        = "zip"
  source_dir  = "../functions/login"
  output_path = "../zipFiles/lambda_login.zip"
}

data "archive_file" "recommendation_zip" {

  type        = "zip"
  source_dir  = "../functions/recommendation"
  output_path = "../zipFiles/lambda_recommendation.zip"
}

data "archive_file" "register_zip" {

  type        = "zip"
  source_dir  = "../functions/register"
  output_path = "../zipFiles/lambda_register.zip"
}

data "archive_file" "users_zip" {

  type        = "zip"
  source_dir  = "../functions/users"
  output_path = "../zipFiles/lambda_users.zip"
}