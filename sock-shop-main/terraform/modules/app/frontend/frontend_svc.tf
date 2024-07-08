resource "kubernetes_service" "kube-front-end-service" {
  metadata {
    name      = "front-end"
    namespace = var.namespace
  /*   annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "front-end"
    }
  }
  spec {
    #type = "LoadBalancer"
    selector = {
      name = "front-end"
    }
    port {
      port        = 80
      target_port = 8079
     # node_port   = 30001
    }
  }
}