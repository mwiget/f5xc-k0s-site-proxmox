terraform {
  required_providers {
    volterra = {
      source  = "volterraedge/volterra"
      version = ">= 0.11.18"
    }
    ct = {
      source  = "poseidon/ct"
      version = ">= 0.11.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.22.0"
    }
    local = ">= 2.2.3"
    null  = ">= 3.1.1"
  }
}
