variable "provider_conf" {
  description = "Configuration for the AWS Provider"
  type        = map(any)

  default = {
    region     = "us-east-1"
    access_key = "-"
    secret_key = "-"
  }
}

variable "app_name" {
  type    = string
  default = "shiftemotion"
}

variable "runtime" {
  description = "Runtimes for Lambdas"
  type        = map(any)

  default = {
    python = "python3.9"
  }
}

variable "id_account" {
  type = string
  default = "-"
}

variable "username"{
  default = "pvirtualizacion"
}

variable "password"{
  default = "pvirtualizacion"
}
