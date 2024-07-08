resource "kubernetes_service" "kube-catalogue-db-service" {
  metadata {
    name      = "catalogue-db"
    namespace = var.namespace
    labels = {
        name = "catalogue-db"
    }
  }
  spec {
    selector = {
      name = "catalogue-db"
    }
    port {
      port        = 3306
      target_port = 3306
    }
  }
}