resource "local_file" "ce_k8s_beta_yaml" {
  content  = local.ce_k8s_beta_yaml
  filename = "./ce_k8s_beta.yaml"
}

locals {
  ce_k8s_beta_yaml = templatefile("./templates/ce_k8s.yaml", {
    cluster_name              = format("%s-beta", var.project_prefix),
    latitude                  = var.latitude,
    longitude                 = var.longitude,
    token                     = volterra_token.site.id,
    site_label                = format("vsite: %s-k0s-clusters", var.project_prefix)
    replicas                  = var.replicas,
    maurice_endpoint_url      = local. maurice_endpoint_url,
    maurice_mtls_endpoint_url = local.maurice_mtls_endpoint_url
  })
  site_get_uri_beta = format("config/namespaces/system/sites/%s-beta", var.project_prefix)
  site_get_url_beta = format("%s/%s?response_format=GET_RSP_FORMAT_DEFAULT", var.f5xc_api_url, local.site_get_uri_beta)
}

resource "null_resource" "ce-k8s-beta" {
  depends_on = [ local_file.ce_k8s_beta_yaml ]
  provisioner "local-exec" {
    command     = "kubectl --kubeconfig=../beta.kubeconfig apply -f ./ce_k8s_beta.yaml"
  }
  provisioner "local-exec" {
    when        = destroy
    on_failure  = continue
    command     = "kubectl --kubeconfig=../beta.kubeconfig delete -f ./ce_k8s_beta.yaml"
  }
}

resource "volterra_registration_approval" "beta" {
  depends_on = [ null_resource.ce-k8s-beta ]
  count = var.replicas
  cluster_name  = format("%s-beta", var.project_prefix)
  cluster_size  = var.replicas
  retry = 10
  wait_time = 60
  hostname = format("vp-manager-%d", count.index)
}

resource "null_resource" "check_site_status_beta" {
  depends_on = [volterra_registration_approval.beta]
  provisioner "local-exec" {
    command     = format("./scripts/check.sh %s %s %s", local.site_get_url_beta, local.f5xc_api_token, local.f5xc_tenant)
    interpreter = ["/usr/bin/env", "bash", "-c"]
  }
}

resource "volterra_site_state" "decommission_when_delete_beta" {
  depends_on = [volterra_registration_approval.beta]
  name       = format("%s-beta", var.project_prefix)
  when       = "delete"
  state      = "DECOMMISSIONING"
  retry      = 5
  wait_time  = 60
}
