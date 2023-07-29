resource "volterra_site_mesh_group" "smg" {
  name        = format("%s-k0s-clusters", var.project_prefix)
  namespace   = "system"
  type        = "full_mesh"
  full_mesh   {
    control_and_data_plane_mesh = true
    data_plane_mesh = false
  }
}

resource "volterra_virtual_site" "vs" {
  name        = format("%s-k0s-clusters", var.project_prefix)
  namespace   = "shared"

  site_selector {
    expressions = [ format("vsite in (%s-k0s-clusters)", var.project_prefix) ]
  }

  site_type = "CUSTOMER_EDGE"
}
