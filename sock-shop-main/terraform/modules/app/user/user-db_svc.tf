resource "kubernetes_service" "kube-user-db-service" {
  metadata {
    name      = "user-db"
    namespace = var.namespace
    labels = {
        name = "user-db"
    }
  }
  spec {
    selector = {
      name = "user-db"
    }
    port {
      port        = 27017
      target_port = 27017
    }
  }
}