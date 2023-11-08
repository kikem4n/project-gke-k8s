## Main variables
variable "project_id" {}
variable "region" {}
variable "zone" {}
variable "credentials" {}

## VPC Variables
variable "vpc_name" {}
variable "subnet_name" {}
variable "ip_cidr_block" {}
variable "routing_mode" {}

## GKE Variables
variable "cluster_name" {}
variable "initial_node_count" {}
variable "machine_type" {}
variable "gke_nodes" {}

## HELM Variables
variable "releases_map" {
  type = map(any)
}
variable "ingress_name" {}
variable "ingress_namespace" {}
variable "ingress_repository" {}
variable "ingress_chart" {}
variable "ingress_create_namespace" {}
