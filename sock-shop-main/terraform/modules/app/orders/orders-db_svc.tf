resource "kubernetes_service" "kube-orders-db-service" {
  metadata {
    name      = "orders-db"
    namespace = var.namespace
    labels = {
        name = "orders-db"
    }
  }
  spec {
    selector = {
      name = "orders-db"
    }
    port {
      port        = 27017
      target_port = 27017
    }
  }
}