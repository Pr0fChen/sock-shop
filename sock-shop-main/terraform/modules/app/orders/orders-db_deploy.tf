resource "kubernetes_deployment" "kube-orders-db-deployment" {
  metadata {
    name      = "orders-db"
    namespace = var.namespace
    labels = {
      name = "orders-db"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "orders-db"
      }
    }
    template {
      metadata {
        labels = {
          name = "orders-db"
        }
      }
      spec {
        container {
          image = "mongo"
          name  = "orders-db"

       port {
        name = "mongo"
        container_port = 27017
      }

      security_context {
        capabilities {
          drop = ["ALL"]
          add = ["CHOWN", "SETGID", "SETUID"]
        }
       # readOnlyRootFilesystem = false
        read_only_root_filesystem = false
            
        }

      volume_mount {
        name = "tmp-volume"
        mount_path = "/tmp"
      }

        }
     volume {
        name = "tmp-volume"
        empty_dir {
            medium = "Memory"
        }
      }
       node_selector = {
        "beta.kubernetes.io/os" = "linux"
      }
      }
    }
  }
}