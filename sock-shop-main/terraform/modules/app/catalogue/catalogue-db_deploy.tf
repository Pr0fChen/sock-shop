resource "kubernetes_deployment" "kube-catalogue-db-deployment" {
  metadata {
    name      = "catalogue-db"
    namespace = var.namespace
    labels = {
      name = "catalogue-db"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "catalogue-db"
      }
    }
    template {
      metadata {
        labels = {
          name = "catalogue-db"
        }
      }
      spec {
        container {
          image = "weaveworksdemos/catalogue-db:0.3.0"
          name  = "catalogue-db"

        port {
        name = "mysql"
        container_port = 3306
      }
      env {
        name = "MYSQL_ROOT_PASSWORD"
        value = "fake_password"
      }

      env {
        name = "MYSQL_DATABASE"
        value = "socksdb"
      }
        }
      
       node_selector = {
        "beta.kubernetes.io/os" = "linux"
      }
    }
  }
}
}