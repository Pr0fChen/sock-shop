resource "kubernetes_deployment" "kube-rabbitmq-deployment" {
  metadata {
    name      = "rabbitmq"
    namespace = var.namespace
    labels = {
      name = "rabbitmq"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "rabbitmq"
      }
    }
    template {
      metadata {
        labels = {
          name = "rabbitmq"
        }
       /*  annotations = {
          "prometheus.io/scrape" = "false"
        } */
      }
      spec {
        container {
          image = "rabbitmq:3.6.8-management"
          name  = "rabbitmq"

      port {
        name = "rabbitmq"
        container_port = 5672
      }

      port {
        name = "management"
        container_port = 15672 
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

        container {
            image = "kbudde/rabbitmq-exporter"
            name  = "rabbitmq-exporter"

            port {
            container_port = 9090
            name = "exporter"
             }
        }

      node_selector = {
        "beta.kubernetes.io/os" = "linux"
      }
      }
    }
  }
}