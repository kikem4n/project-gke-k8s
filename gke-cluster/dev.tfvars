## Main variables
project_id  = "careful-plexus-402523"
region      = "us-east4"
zone        = "us-east4-a"
credentials = ".//gcp-keys.json"

## VPC Variables
vpc_name      = "gke-vpc"
subnet_name   = "gke"
ip_cidr_block = "10.0.1.0/24"
routing_mode  = "GLOBAL"

## GKE Variables
regional           = false
cluster_name       = "gke-cluster"
initial_node_count = "1"
machine_type       = "e2-medium"
gke_nodes          = "2"
oauth_scopes = [
  "https://www.googleapis.com/auth/logging.write",
  "https://www.googleapis.com/auth/monitoring",
]
disk_size_gb = "10"
node_locations = [
  "us-east4-a",
  "us-east4-b",
  "us-east4-c"
]

## UPTIME_CHECK Variables
uptime_type = "k8s_service"
uptime_config = {
  "HTTP_GKE_Check_Backend_1" = {
    checker_type    = "STATIC_IP_CHECKERS"
    checker_period  = "60s"
    checker_timeout = "10s"
    path            = "/backend1"
    port            = "80"
  }
  "HTTP_GKE_Check_Backend_2" = {
    checker_type    = "STATIC_IP_CHECKERS"
    checker_period  = "60s"
    checker_timeout = "10s"
    path            = "/backend2"
    port            = "80"
  }
  "HTTP_GKE_Check_Backend_3" = {
    checker_type    = "STATIC_IP_CHECKERS"
    checker_period  = "60s"
    checker_timeout = "10s"
    path            = "/backend3"
    port            = "80"
  }
}


## HELM Variables
releases_map = {
  "gke-backend-1" = {
    chart_source       = "../hello-kubernetes"
    namespace          = "gke-hw"
    create_namespace   = true
    service_type       = "ClusterIP"
    replica_count      = "3"
    service_port       = "80"
    container_image    = "paulbouwer/hello-kubernetes"
    image_version      = "1.10"
    ingress_configured = true
    path_prefix        = "backend1"
    message            = "Hello World from First Backend"
  }
  "gke-backend-2" = {
    chart_source       = "../hello-kubernetes"
    namespace          = "gke-hw"
    create_namespace   = true
    service_type       = "ClusterIP"
    replica_count      = "3"
    service_port       = "80"
    container_image    = "paulbouwer/hello-kubernetes"
    image_version      = "1.10"
    ingress_configured = true
    path_prefix        = "backend2"
    message            = "Hello World from Second Backend"
  }
  "gke-backend-3" = {
    chart_source       = "../hello-kubernetes"
    namespace          = "gke-hw"
    create_namespace   = true
    service_type       = "ClusterIP"
    replica_count      = "3"
    service_port       = "80"
    container_image    = "paulbouwer/hello-kubernetes"
    image_version      = "1.10"
    ingress_configured = true
    path_prefix        = "backend3"
    message            = "Hello World from Third Backend"
  }
}

ingress_name                 = "ingress-nginx"
ingress_controller_namespace = "ingress"
ingress_namespace            = "gke-hw"
ingress_repository           = "https://kubernetes.github.io/ingress-nginx"
ingress_chart                = "ingress-nginx"
ingress_create_namespace     = true