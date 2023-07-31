resource "kubernetes_deployment" "f5-demo-httpd" {
  metadata {
    name = "f5-demo-httpd"
    namespace = kubernetes_namespace.beta.id
    labels = {
      app = "f5-demo-httpd"
    }
  }

  spec {
    replicas = 4

    selector {
      match_labels = {
        app = "f5-demo-httpd"
      }
    }

    template {
      metadata {
        labels = {
          app = "f5-demo-httpd"
        }
      }

      spec {
        container {
          image = "f5devcentral/f5-demo-httpd:nginx"
          name  = "f5-demo-httpd"

          liveness_probe {
            http_get {
              path = "/txt"
              port = 80

              http_header {
                name = "X-Custom-Header"
                value = "liveness_probe"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 5
          }

          env {
            name    = "F5DEMO_APP"
            value   = "website"
          }
          env {
            name    = "F5DEMO_NODENAME"
            value   = "marcel-beta"
          }
          env {
            name    = "F5DEMO_COLOR"
            value   = "ed7b0c"        # orange
          }
        }
      }
    }
  }
  provider = kubernetes.beta
}

resource "kubernetes_service" "ks" {
  metadata {
    name = "f5-demo-httpd"
    namespace = kubernetes_namespace.beta.id
  }
  spec {
    selector = {
      app = kubernetes_deployment.f5-demo-httpd.metadata.0.labels.app
    }
    session_affinity = "None"
    port {
      port        = 8080
      target_port = 80
    }

    type = "ClusterIP"
  }
  provider = kubernetes.beta
}

output "f5-demo-http" {
  value = kubernetes_deployment.f5-demo-httpd
}
