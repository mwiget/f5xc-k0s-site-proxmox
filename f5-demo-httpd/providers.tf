provider "volterra" {
  api_p12_file = var.f5xc_api_p12_file
  url          = var.f5xc_api_url
}

provider "kubernetes" {
  config_path    = "../alpha.kubeconfig"
  alias = "alpha"
}

provider "kubernetes" {
  config_path    = "../beta.kubeconfig"
  alias = "beta"
}

