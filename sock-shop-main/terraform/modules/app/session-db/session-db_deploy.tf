resource "kubernetes_deployment" "kube-session-db-deployment" {
  metadata {
    name      = "session-db"
    namespace = var.namespace
    labels = {
      name = "session-db"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "session-db"
      }
    }
    template {
      metadata {
        labels = {
          name = "session-db"
        }
       /*  annotations = {
          prometheus.io.scrape = "false"
        } */
      }
      spec {
        container {
          image = "redis:alpine"
          name  = "session-db"

      port {
        name = "redis"
        container_port = 6379
      }

      security_context {
        capabilities {
          drop = ["ALL"]
          add = ["CHOWN", "SETGID", "SETUID"]
        }
        #readOnlyRootFilesystem = false
        read_only_root_filesystem = false
      }
     
      }
        node_selector = {
        "beta.kubernetes.io/os" = "linux"
      }
    }
  }
}
}