resource "helm_release" "prometheus" {
  depends_on = [helm_release.helm_releases]
  name       = var.prometheus_name
  namespace  = var.prometheus_namespace

  repository       = var.prometheus_repository
  chart            = var.prometheus_chart
  create_namespace = var.prometheus_create_namespace

  set {
    name  = "controller.replicaCount"
    value = 2
  }
  set {
    name  = "prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues"
    value = false
  }
  set {
    name  = "prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues"
    value = false
  }    
}

resource "kubernetes_ingress_v1" "ingress-prometheus" {
  depends_on             = [helm_release.helm_releases]
  wait_for_load_balancer = true
  metadata {
    name      = "${var.prometheus_name}-ingress"
    namespace = var.prometheus_namespace
    annotations = {
      "kubernetes.io/ingress.class"                = "nginx"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$1"
    }
  }
  spec {
    rule {
      http {
        path {
          backend {
            service {
              name = "prometheus-grafana"
              port {
                number = 80
              }
            }
          }
          path      = "/?(.*)"
          path_type = "ImplementationSpecific"
        }      
      }
    }
  }
}