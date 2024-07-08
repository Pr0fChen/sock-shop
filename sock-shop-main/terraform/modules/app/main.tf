# Appel des modules de déploiement des applications
resource "kubernetes_namespace" "kube-namespace" {
  metadata {
    name = "sock-shop"
  }
}

module "carts" {
  source = "./carts"
  namespace = kubernetes_namespace.kube-namespace.id
}

module "catalogue" {
  source = "./catalogue"
  namespace = kubernetes_namespace.kube-namespace.id
}

module "frontend" {
  source = "./frontend"
  namespace = kubernetes_namespace.kube-namespace.id
}

module "orders" {
  source = "./orders"
  namespace = kubernetes_namespace.kube-namespace.id
}

module "payments" {
  source = "./payments"
  namespace = kubernetes_namespace.kube-namespace.id
}

module "queue" {
  source = "./queue"
  namespace = kubernetes_namespace.kube-namespace.id
}

module "rabbitmq" {
  source = "./rabbitmq"
  namespace = kubernetes_namespace.kube-namespace.id
}

module "session-db" {
  source = "./session-db"
  namespace = kubernetes_namespace.kube-namespace.id
}

module "shipping" {
  source = "./shipping"
  namespace = kubernetes_namespace.kube-namespace.id
}

module "user" {
  source = "./user"
  namespace = kubernetes_namespace.kube-namespace.id
}
