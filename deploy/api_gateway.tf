// API Gateway configuration
resource "aws_api_gateway_rest_api" "api_gateway" {

  name = "${var.app_name}-api-rest"
  description = "API Gateway de ${var.app_name}"
}
/*
resource "aws_api_gateway_deployment" "api_deploy" {

  rest_api_id = aws_api_gateway_rest_api.api_gateway.id

  lifecycle {
    create_before_destroy = true
  }

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.api_gateway.body))
  }

  depends_on = [
    aws_api_gateway_integration.integration_lambda_createStand,
    aws_api_gateway_integration.integration_lambda_getStands,
    aws_api_gateway_integration.integration_stand_cors,
    aws_api_gateway_integration.integration_lambda_saveMedia,
    aws_api_gateway_integration.integration_stand_media_cors,
    aws_api_gateway_integration.integration_lambda_createUser,
    aws_api_gateway_integration.integration_user_cors
  ]
}

resource "aws_api_gateway_stage" "api_gw_stage" {

  deployment_id = aws_api_gateway_deployment.api_deploy.id
  rest_api_id   = aws_api_gateway_rest_api.api_gateway.id
  stage_name    = "prod"
}

resource "aws_api_gateway_api_key" "api_key" {

  name = "${var.app_name}-prod-api-key"
}

resource "aws_api_gateway_usage_plan" "api_gw_usage_plan" {

  name = "${var.app_name}-prod-api-gw-usage-plan"

  api_stages {

    api_id = aws_api_gateway_rest_api.api_gateway.id
    stage  = aws_api_gateway_stage.api_gw_stage.stage_name
  }
}

resource "aws_api_gateway_usage_plan_key" "usage_plan_api_key" {

  key_id        = aws_api_gateway_api_key.api_key.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api_gw_usage_plan.id
}
*/