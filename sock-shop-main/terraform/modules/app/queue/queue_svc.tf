resource "kubernetes_service" "kube-queue-master-service" {
  metadata {
    name      = "queue-master"
    namespace = var.namespace
  /*   annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "queue-master"
    }
  }
  spec {
    selector = {
      name = "queue-master"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}