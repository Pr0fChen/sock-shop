resource "kubernetes_service" "kube-catalogue-service" {
  metadata {
    name      = "catalogue"
    namespace = var.namespace
   /*  annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "catalogue"
    }
  }
  spec {
    selector = {
      name = "catalogue"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}