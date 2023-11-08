terraform {
  backend "gcs" {
    bucket      = "gcp-terraform-kikeman"
    prefix      = "gke/terraform.tfstate"
    credentials = "gcp-keys.json"
  }  
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.4.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.23.0"
    }    
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
  credentials = var.credentials
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke.cluster_endpoint}"
    token                  = module.gke.cluster_access_token
    cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
  }
}

provider "kubernetes" {
    host                   = "https://${module.gke.cluster_endpoint}"
    token                  = module.gke.cluster_access_token
    cluster_ca_certificate = base64decode(module.gke.cluster_ca_certificate)
}

module "gke" {
  source             = ".//modules/gke"
  region             = var.region
  zone               = var.zone
  cluster_name       = var.cluster_name
  initial_node_count = var.initial_node_count
  machine_type       = var.machine_type
  vpc_id             = module.vpc.vpc_id
  subnetwork_id      = module.vpc.subnetwork_id
  gke_nodes          = var.gke_nodes
  project_id         = var.project_id
}

module "vpc" {
  source        = ".//modules/vpc"
  vpc_name      = var.vpc_name
  region        = var.region
  subnet_name   = var.subnet_name
  ip_cidr_block = var.ip_cidr_block
  routing_mode  = var.routing_mode
}

module "helm" {
  source                   = ".//modules/helm"
  releases_map             = var.releases_map
  ingress_name             = var.ingress_name
  ingress_namespace        = var.ingress_namespace
  ingress_repository       = var.ingress_repository
  ingress_chart            = var.ingress_chart
  ingress_create_namespace = var.ingress_create_namespace
}
