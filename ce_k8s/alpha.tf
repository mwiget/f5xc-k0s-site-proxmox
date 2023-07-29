resource "local_file" "ce_k8s_alpha_yaml" {
  content  = local.ce_k8s_alpha_yaml
  filename = "./ce_k8s_alpha.yaml"
}

locals {
  ce_k8s_alpha_yaml = templatefile("./templates/ce_k8s.yaml", {
    cluster_name              = format("%s-alpha", var.project_prefix),
    latitude                  = var.latitude,
    longitude                 = var.longitude,
    token                     = volterra_token.site.id,
    site_label                = format("vsite: %s-k0s-clusters", var.project_prefix)
    replicas                  = var.replicas,
    maurice_endpoint_url      = local. maurice_endpoint_url,
    maurice_mtls_endpoint_url = local.maurice_mtls_endpoint_url
  })
  site_get_uri_alpha = format("config/namespaces/system/sites/%s-alpha", var.project_prefix)
  site_get_url_alpha = format("%s/%s?response_format=GET_RSP_FORMAT_DEFAULT", var.f5xc_api_url, local.site_get_uri_alpha)
}

resource "null_resource" "ce-k8s-alpha" {
  depends_on = [ local_file.ce_k8s_alpha_yaml ]
  provisioner "local-exec" {
    command     = "kubectl --kubeconfig=../alpha.kubeconfig apply -f ./ce_k8s_alpha.yaml"
  }
  provisioner "local-exec" {
    when        = destroy
    on_failure  = continue
    command     = "kubectl --kubeconfig=../alpha.kubeconfig delete -f ./ce_k8s_alpha.yaml"
  }
}

resource "volterra_registration_approval" "alpha" {
  depends_on = [ null_resource.ce-k8s-alpha ]
  count = var.replicas
  cluster_name  = format("%s-alpha", var.project_prefix)
  cluster_size  = var.replicas
  retry = 10
  wait_time = 60
  hostname = format("vp-manager-%d", count.index)
}

resource "null_resource" "check_site_status_alpha" {
  depends_on = [volterra_registration_approval.alpha]
  provisioner "local-exec" {
    command     = format("./scripts/check.sh %s %s %s", local.site_get_url_alpha, local.f5xc_api_token, local.f5xc_tenant)
    interpreter = ["/usr/bin/env", "bash", "-c"]
  }
}

resource "volterra_site_state" "decommission_when_delete_alpha" {
  depends_on = [volterra_registration_approval.alpha]
  name       = format("%s-alpha", var.project_prefix)
  when       = "delete"
  state      = "DECOMMISSIONING"
  retry      = 5
  wait_time  = 60
}
