resource "kubernetes_service" "kube-rabbitmq-service" {
  metadata {
    name      = "rabbitmq"
    namespace = var.namespace
/*     annotations = {
        prometheus.io/scrape: "true"
        prometheus.io/port: "9090"
    } */
    labels = {
        name = "rabbitmq"
    }
  }
  spec {
    selector = {
      name = "rabbitmq"
    }
    port {
      name = "rabbitmq"
      port        = 5672
      target_port = 5672
    }
    port {
        protocol = "TCP"
        name = "exporter"
        port        = 9090
        target_port = "exporter"
    }
  }
}