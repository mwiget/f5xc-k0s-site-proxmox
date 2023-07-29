resource "volterra_virtual_site" "vs" {
  name        = format("%s-k0s-clusters", var.project_prefix)
  namespace   = "shared"

  site_selector {
    expressions = [ format("vsite in (%s-k0s-clusters)", var.project_prefix) ]
  }

  site_type = "CUSTOMER_EDGE"
}

resource "volterra_site_mesh_group" "smg" {
  name        = format("%s-k0s-clusters", var.project_prefix)
  namespace   = "system"
  type        = "SITE_MESH_GROUP_TYPE_FULL_MESH"

  virtual_site {
    name = volterra_virtual_site.vs.name
    namespace = "shared"
  }
}

