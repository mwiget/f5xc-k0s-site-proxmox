resource "volterra_namespace" "ns" {
  name = var.f5xc_namespace
}

resource "time_sleep" "wait_10_seconds" {
  depends_on      = [volterra_namespace.ns]
  create_duration = "10s"
}

resource "null_resource" "next" {
  depends_on = [time_sleep.wait_10_seconds]
}

resource "kubernetes_namespace" "alpha" {
  metadata {
    name = var.f5xc_namespace
  }
  provider = kubernetes.alpha
}

resource "kubernetes_namespace" "beta" {
  metadata {
    name = var.f5xc_namespace
  }
  provider = kubernetes.beta
}

output "kubernetes_namespace_alpha" {
  value = kubernetes_namespace.alpha.id
}

output "kubernetes_namespace_beta" {
  value = kubernetes_namespace.beta.id
}

output "volterra_namespace" {
  value = volterra_namespace.ns.name
  
}

