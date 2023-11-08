resource "helm_release" "ingress-nginx" {
  name      = var.ingress_name
  namespace = var.ingress_namespace

  repository       = var.ingress_repository
  chart            = var.ingress_chart
  create_namespace = var.ingress_create_namespace

  set {
    name  = "controller.replicaCount"
    value = 2
  }
}

resource "kubernetes_ingress_v1" "ingress-nginx" {
  wait_for_load_balancer = true
  metadata {
    name = var.ingress_name
    namespace = "gke-hw"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$2"
    }
  }
  spec{
    rule {
      http {
        dynamic "path" {
          for_each = var.releases_map
          content {
            backend {
              service {
                name = "hello-kubernetes-${path.key}"
                port {
                  number = path.value.service_port
                }                
              }
            }
            path = "/${path.value.path_prefix}(/|$)(.*)"
          }
        }
      }
    }
  }
}