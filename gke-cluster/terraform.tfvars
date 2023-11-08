## Main variables
project_id  = "careful-plexus-402523"
region      = "us-east4"
zone        = "us-east4-a"
credentials = ".//gcp-keys.json"

## VPC Variables
vpc_name      = "gke-vpc"
subnet_name   = "gke"
ip_cidr_block = "10.0.1.0/24"
routing_mode  = "REGIONAL"

## GKE Variables
cluster_name       = "gke-cluster"
initial_node_count = "1"
machine_type       = "n1-standard-1"
gke_nodes          = "3"

## HELM Variables
releases_map = {
  "gke-custom-message" = {
    chart_source       = "./hello-kubernetes"
    namespace          = "gke-hw"
    create_namespace   = true
    service_type       = "ClusterIP"
    replica_count      = "3"
    service_port       = "80"
    container_image    = "paulbouwer/hello-kubernetes"
    image_version      = "1.10"
    ingress_configured = true
    path_prefix        = "custom-message"
    message            = "Hello World from Second Backend"
  }
  "gke-hello-world" = {
    chart_source       = "./hello-kubernetes"
    namespace          = "gke-hw"
    create_namespace   = true
    service_type       = "ClusterIP"
    replica_count      = "3"
    service_port       = "80"
    container_image    = "paulbouwer/hello-kubernetes"
    image_version      = "1.10"
    ingress_configured = true
    path_prefix        = "hello-world"
    message            = "Hello World from First Backend"
  }
  "gke-show-me-the-money" = {
    chart_source       = "./hello-kubernetes"
    namespace          = "gke-hw"
    create_namespace   = true
    service_type       = "ClusterIP"
    replica_count      = "3"
    service_port       = "80"
    container_image    = "paulbouwer/hello-kubernetes"
    image_version      = "1.10"
    ingress_configured = true
    path_prefix        = "shm"
    message            = "Show Me The Money"
  }  
}

ingress_name             = "ingress-nginx"
ingress_namespace        = "ingress"
ingress_repository       = "https://kubernetes.github.io/ingress-nginx"
ingress_chart            = "ingress-nginx"
ingress_create_namespace = true

