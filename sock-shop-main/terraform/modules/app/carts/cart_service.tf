resource "kubernetes_service" "kube-carts-service" {
  metadata {
    name      = "carts"
    namespace = var.namespace
  /*   annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "carts"
    }
  }
  spec {
    selector = {
      name = "carts"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}