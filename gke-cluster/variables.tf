## Main variables
variable "project_id" {
  description = "Google Account Project ID"
}
variable "region" {
  description = "Google Account Region"
}
variable "zone" {
  description = "Google Account Location"
}
variable "credentials" {
  description = "Service Account keys in JSON file format"
}

## VPC Variables
variable "vpc_name" {
  description = "Name of the Google VPC"
}
variable "subnet_name" {
  description = "Name of the Google Subnet"
}
variable "ip_cidr_block" {
  description = "IPV4 CIDR block"
}
variable "routing_mode" {
  description = "Routing mode of the VPC"
}

## GKE Variables
variable "cluster_name" {
  description = "Google Kubernetes Engine cluster name"
}
variable "initial_node_count" {
  description = "GKE Node Initial Count"
}
variable "machine_type" {
  description = "Type and family of the machine"
}
variable "gke_nodes" {
  description = "Number of nodes to create in GKE"
}

## UPTIME_CHECK Variables
variable "uptime_config" {
  description = "Map of the Uptime check configurations"
}
variable "uptime_type" {
  description = "Uptime check type"
}

## HELM Variables
variable "releases_map" {
  description = "Map pf the parameters to be used by HELM in the YAML Manifests"
  type = map(any)
}
variable "ingress_name" {
  description = "Name of the Ingress Controller"
}
variable "ingress_controller_namespace" {
  description = "Namespace of the Ingress Controller"
}
variable "ingress_namespace" {
  description = "Namespace to deploy the Ingress"
}
variable "ingress_repository" {
  description = "Ingress public repository path"
}
variable "ingress_chart" {
  description = "Ingress HELM Chart name"
}
variable "ingress_create_namespace" {
  description = "To decide if create the Ingress Namespace if not exisiting"
}