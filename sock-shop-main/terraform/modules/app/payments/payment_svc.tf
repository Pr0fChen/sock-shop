resource "kubernetes_service" "kube-payment-service" {
  metadata {
    name      = "payment"
    namespace = var.namespace
  /*   annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "payment"
    }
  }
  spec {
    selector = {
      name = "payment"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}