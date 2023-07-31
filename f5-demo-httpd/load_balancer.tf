resource "volterra_http_loadbalancer" "lb" {
  name                            = format("%s-f5-httpd-demo", var.project_prefix)
  namespace                       = var.f5xc_namespace
  no_challenge                    = true
  domains                         = [ "f5-httpd-demo" ]

  disable_rate_limit              = true
  service_policies_from_namespace = true
  disable_waf                     = true

  advertise_custom {
    #    advertise_where {
    #  site {
    #    network = "SITE_NETWORK_SERVICE"
    #    site {
    #      name      = format("%s-alpha", var.project_prefix)
    #      namespace = "system"
    #    }
    #  }
    #}
    advertise_where {
      #      port = 80
      site {
        network = "SITE_NETWORK_OUTSIDE"
        site {
          name      = format("%s-alpha", var.project_prefix)
          namespace = "system"
        }
      }
    }
  }

  default_route_pools {
    pool {
      name = volterra_origin_pool.op.name
    }
    weight = 1
    priority = 1
  }

  http {
    dns_volterra_managed = false
  }

  depends_on = [ volterra_origin_pool.op ]
}

output "http_loadbalancer" {
  value = resource.volterra_http_loadbalancer.lb
}
