resource "kubernetes_service" "kube-orders-service" {
  metadata {
    name      = "orders"
    namespace = var.namespace
    /* annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "orders"
    }
  }
  spec {
    selector = {
      name = "orders"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}