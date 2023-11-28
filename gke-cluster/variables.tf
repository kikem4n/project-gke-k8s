## Main variables
variable "project_id" {
  description = "Google Account Project ID"
  type        = string
}
variable "region" {
  description = "Google Account Region"
  type        = string
  default     = "us-east4"
}
variable "zone" {
  description = "Google Account Zone"
  type        = string
}
variable "regional" {
  description = "Whether deploy a Regional or Zonal cluster"
  type        = bool
  default     = false
}
variable "credentials" {
  description = "Service Account keys in JSON file format"
  type        = string
}

## VPC Variables
variable "vpc_name" {
  description = "Name of the Google VPC"
  type        = string
}
variable "subnet_name" {
  description = "Name of the Google Subnet"
  type        = string
}
variable "ip_cidr_block" {
  description = "IPV4 CIDR block"
  type        = string
}
variable "routing_mode" {
  description = "Routing mode of the VPC"
  type        = string
}

## GKE Variables
variable "cluster_name" {
  description = "Google Kubernetes Engine cluster name"
  type        = string
}
variable "initial_node_count" {
  description = "GKE Node Initial Count"
  type        = string
  default     = "1"
}
variable "machine_type" {
  description = "Type and family of the machine"
  type        = string
}
variable "gke_nodes" {
  description = "Number of nodes to create in GKE"
  type        = string
}
variable "node_locations" {
  description = "Node Locations"
  type        = list(string)
  default     = ["us-east4-a", "us-east4-b", "us-east4-c"]
}
variable "oauth_scopes" {
  description = "OAuth scopes of the node."
  type        = list(string)
  default = [
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring"
  ]
}
variable "disk_size_gb" {
  description = "Size of disk in GB"
  type        = string
}

## UPTIME_CHECK Variables
variable "uptime_config" {
  description = "Map of the Uptime check configurations"
  type        = map(any)
}
variable "uptime_type" {
  description = "Uptime check type"
  type        = string
}

## HELM Variables
variable "releases_map" {
  description = "Map pf the parameters to be used by HELM in the YAML Manifests"
  type        = map(any)
}
variable "ingress_name" {
  description = "Name of the Ingress Controller"
  type        = string
}
variable "ingress_controller_namespace" {
  description = "Namespace of the Ingress Controller"
  type        = string
}
variable "ingress_namespace" {
  description = "Namespace to deploy the Ingress"
  type        = string
}
variable "ingress_repository" {
  description = "Ingress public repository path"
  type        = string
}
variable "ingress_chart" {
  description = "Ingress HELM Chart name"
  type        = string
}
variable "ingress_create_namespace" {
  description = "To decide if create the Ingress Namespace if not exisiting"
  type        = string
}

variable "prometheus_name" {
  description = "Name of the prometheus Controller"
  type        = string
}
variable "prometheus_namespace" {
  description = "Namespace to deploy the prometheus"
  type        = string
}
variable "prometheus_repository" {
  description = "prometheus public repository path"
  type        = string
}
variable "prometheus_chart" {
  description = "prometheus HELM Chart name"
  type        = string
}
variable "prometheus_create_namespace" {
  description = "To decide if create the prometheus Namespace if not exisiting"
  type        = string
}