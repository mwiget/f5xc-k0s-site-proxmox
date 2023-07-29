variable "project_prefix" {
  type        = string
  default     = "prefix"
}

variable "f5xc_api_p12_file" {
  type = string
}

variable "f5xc_api_url" {
  type = string
}

variable "f5xc_api_token" {
  type = string
}

variable "f5xc_api_ca_cert" {
  type = string
  default = ""
}

variable "f5xc_tenant" {
  type = string
}

variable "f5xc_namespace" {
  type    = string
  default = "system"
}

variable "owner" {}

variable "kubernetes_version" {
  type    = string
  default = "1.23"
}

variable "replicas" {
  type    = number
  default = 3
}

variable "latitude" {
  type    = number
  default = 37
}

variable "longitude" {
  type    = number
  default = -121
}

