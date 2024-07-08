resource "kubernetes_namespace" "kube-namespace" {

  metadata {
    name = var.namespace
  }
}

resource "helm_release" "prometheus" {
  depends_on = [
    kubernetes_namespace.kube-namespace 
  ]
  
  name             = var.helm_release_name
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = var.namespace
  create_namespace = true
  version          = var.prometheus_version
  
  values = [
    file("${path.module}/values.yaml")
  ]
  
  timeout = 2000

  set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }

  set {
    name  = "server\\.resources"
    value = yamlencode({
      limits = {
        cpu    = "200m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "30Mi"
      }
    })
  }
}
