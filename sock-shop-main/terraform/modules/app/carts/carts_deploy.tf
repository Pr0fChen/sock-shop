resource "kubernetes_deployment" "kube-carts-deployment" {
  metadata {
    name      = "carts"
    namespace = var.namespace
    labels = {
      name = "carts"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "carts"
      }
    }
    template {
      metadata {
        labels = {
          name = "carts"
        }
      }
      spec {
        container {
          image = "weaveworksdemos/carts:0.4.8"
          name  = "carts"

      env {
        name = "JAVA_OPTS"
        value = "-Xms64m -Xmx128m -XX:+UseG1GC -Djava.security.egd=file:/dev/urandom -Dspring.zipkin.enabled=false"
      }

      resources {
        limits = {
          cpu = "300m"
          memory = "500Mi"
        }
        requests = {
          cpu = "100m"
          memory = "200Mi"
        }
      }

      port {
        container_port = 80
      }

      security_context {
        capabilities {
          drop = ["ALL"]
          add = ["NET_BIND_SERVICE"]
        }
        read_only_root_filesystem = true
        run_as_non_root = true
        run_as_user = 10001
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
         
      }
    }
  }
}