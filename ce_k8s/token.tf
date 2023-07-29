resource "volterra_token" "site" {
  name      = format("%s-k0s-clusters", var.project_prefix)
  namespace = "system"
}
