resource "kubernetes_service" "kube-session-db-service" {
  metadata {
    name      = "cartsession-dbs"
    namespace = var.namespace

    labels = {
        name = "session-db"
    }
  }
  spec {
    selector = {
      name = "session-db"
    }
    port {
      port        = 6379
      target_port = 6379
    }
  }
}