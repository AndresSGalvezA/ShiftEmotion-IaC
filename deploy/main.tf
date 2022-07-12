terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
  }
}

provider "aws" {
  region     = var.provider_conf.region
  access_key = var.provider_conf.access_key
  secret_key = var.provider_conf.secret_key
}
