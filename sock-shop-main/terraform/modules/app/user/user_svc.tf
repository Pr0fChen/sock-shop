resource "kubernetes_service" "kube-user-service" {
  metadata {
    name      = "user"
    namespace = var.namespace
  /*   annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "user"
    }
  }
  spec {
    selector = {
      name = "user"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}