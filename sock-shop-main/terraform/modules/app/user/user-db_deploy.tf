resource "kubernetes_deployment" "kube-user-db-deployment" {
  metadata {
    name      = "user-db"
    namespace = var.namespace
    labels = {
      name = "user-db"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "user-db"
      }
    }
    template {
      metadata {
        labels = {
          name = "user-db"
        }
      }
      spec {
        container {
          image = "weaveworksdemos/user-db:0.3.0"
          name  = "user-db"

       port {
        name = "mongo"
        container_port = 27017
      }

      security_context {
        capabilities {
          drop = ["ALL"]
          add = ["CHOWN", "SETGID", "SETUID"]
        }
        read_only_root_filesystem = true
       # readOnlyRootFilesystem = false
            
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