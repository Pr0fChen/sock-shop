resource "kubernetes_deployment" "kube-carts-db-deployment" {
  metadata {
    name      = "carts-db"
    namespace = var.namespace
    labels = {
      name = "carts-db"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "carts-db"
      }
    }
    template {
      metadata {
        labels = {
          name = "carts-db"
        }
      }
      spec {
        container {
          image = "mongo"
          name  = "carts-db"

       port {
        name = "mongo"
        container_port = 80
      }

      security_context {
        capabilities {
          drop = ["ALL"]
          add = ["CHOWN", "SETGID", "SETUID"]
        }

        #readOnlyRootFilesystem = false
        read_only_root_filesystem = true
            
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