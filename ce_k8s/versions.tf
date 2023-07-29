terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.8.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }

    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.11.24"
    }
  }

  required_version = ">= 1.4.0"
}

