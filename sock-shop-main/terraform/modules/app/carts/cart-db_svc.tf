resource "kubernetes_service" "kube-carts-db-service" {
  metadata {
    name      = "carts-db"
    namespace = var.namespace
    labels = {
        name = "carts-db"
    }
  }
  spec {
    selector = {
      name = "carts-db"
    }
    port {
      port        = 27017
      target_port = 27017
    }
  }
}