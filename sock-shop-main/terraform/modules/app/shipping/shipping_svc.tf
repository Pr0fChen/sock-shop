resource "kubernetes_service" "kube-shipping-service" {
  metadata {
    name      = "shipping"
    namespace = var.namespace

    labels = {
        name = "shipping"
    }
  }
  spec {
    selector = {
      name = "shipping"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}