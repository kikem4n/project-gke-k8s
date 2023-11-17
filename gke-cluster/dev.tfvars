## Main variables
project_id  = "gcp-dev-405122" #>>> GCP Project ID, change it to yours 
region      = "us-east4"       #>>> GCP Region
zone        = "us-east4-a"     #>>> GCP Zone from the region
credentials = ".//gcp-keys.json"

## VPC Variables
vpc_name      = "gke-dev-vpc" #>>> VPC Name
subnet_name   = "gke-dev"     #>>> Subnet Name
ip_cidr_block = "10.1.0.0/16" #>>> Subnet Cidr
routing_mode  = "GLOBAL"      #>>> Routing mode

## GKE Variables
regional           = false             #>>> Set to false to create Zonal Cluster, set to true to create Regional Cluster
cluster_name       = "gke-dev-cluster" #>>> Cluster Name
initial_node_count = "1"               #>>> Initail Node count
machine_type       = "e2-medium"       #>>> Machine type
gke_nodes          = "3"               #>>> Number of nodes to be created, if Zonal Cluster is set, then choose # of desired nodes, If Regional Cluster is set, the number of nodes selected will be equivalent to the zones per region. 
oauth_scopes = [                       #>>> Cluster OAuth Scopes
  "https://www.googleapis.com/auth/logging.write",
  "https://www.googleapis.com/auth/monitoring",
]
disk_size_gb = "10" #>>> Cluster Disk Size
node_locations = [  #>>> Zones to be selected if Regional Cluster is set
  "us-east4-a",
  "us-east4-b",
  "us-east4-c"
]

## UPTIME_CHECK Variables
uptime_type = "k8s_service"      #>>> Uptime type
uptime_config = {                #>>> Uptime config map
  "HTTP_GKE_Check_Backend_1" = { #>>> Uptime Check, if want a new one copy this block and add it to the map
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
  # "HTTP_GKE_Check_Backend_3" = { #>>> Uncomment the block to create this new Uptime Check
  #   checker_type    = "STATIC_IP_CHECKERS"
  #   checker_period  = "60s"
  #   checker_timeout = "10s"
  #   path            = "/backend3"
  #   port            = "80"
  # }
}


## HELM Variables
releases_map = {
  "gke-backend-1" = { #>>> HELM Release, if want a new one copy this block and add it to the map
    chart_source       = "../hello-kubernetes"
    namespace          = "gke-dev-hw"
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
    namespace          = "gke-dev-hw"
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
  # "gke-backend-3" = {   #>>> Uncomment the block to create this new HELM release
  #   chart_source       = "../hello-kubernetes"
  #   namespace          = "gke-hw"
  #   create_namespace   = true
  #   service_type       = "ClusterIP"
  #   replica_count      = "3"
  #   service_port       = "80"
  #   container_image    = "paulbouwer/hello-kubernetes"
  #   image_version      = "1.10"
  #   ingress_configured = true
  #   path_prefix        = "backend3"
  #   message            = "Hello World from Third Backend"
  # }
}

ingress_name                 = "ingress-nginx"                              #>>> Ingress Name
ingress_controller_namespace = "ingress-dev"                                #>>> Ingress Controller Namespace
ingress_namespace            = "gke-dev-hw"                                 #>>> Namespace to create the Ingress Manifest, set it in the same namespace as your application HELM Releases
ingress_repository           = "https://kubernetes.github.io/ingress-nginx" #>>> Ingress Controller public Repository
ingress_chart                = "ingress-nginx"                              #>>> Chart to be installed
ingress_create_namespace     = true                                         #>>> Set to true to create the Ingress Controller namespace.