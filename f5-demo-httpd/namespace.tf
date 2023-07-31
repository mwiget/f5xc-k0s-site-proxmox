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

resource "kubernetes_namespace" "ns" {
  metadata {
    name = var.f5xc_namespace
  }
}

output "kubernetes_namespace" {
  value = kubernetes_namespace.ns.id
}

output "volterra_namespace" {
  value = volterra_namespace.ns.name
  
}

