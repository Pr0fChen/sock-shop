resource "kubernetes_deployment" "kube-front-end-deployment" {
  metadata {
    name      = "front-end"
    namespace = var.namespace
    labels = {
      name = "front-end"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "front-end"
      }
    }
    template {
      metadata {
        labels = {
          name = "front-end"
        }
      }
      spec {
        container {
          image = "weaveworksdemos/front-end:0.3.12"
          name  = "front-end"
        
        env {
        name = "SESSION_REDIS"
        value = "true"
      }

      resources {
        limits = {
          cpu = "300m"
          memory = "1000Mi"
        }
        requests = {
          cpu = "100m"
          memory = "300Mi"
        }
      }

      port {
        container_port = 8079
      }

      security_context {
        capabilities {
          drop = ["ALL"]
        }
        read_only_root_filesystem = true
        run_as_non_root = true
        run_as_user = 10001
        #readOnlyRootFilesystem = true
        #runAsNonRoot = true
        #runAsUser = 10001
      }

      liveness_probe {
        http_get {
          path = "/"
          port = 8079
        }
        initial_delay_seconds = 300
        period_seconds = 3
      }

      readiness_probe {
        http_get {
          path = "/"
          port = 8079
        }
        initial_delay_seconds = 30
        period_seconds = 3
      }
        }
       
       node_selector = {
        "beta.kubernetes.io/os" = "linux"
      }
    }
  }
}

}