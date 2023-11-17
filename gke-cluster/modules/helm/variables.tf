variable "releases_map" {
  type = map(any)
}
variable "ingress_name" {}
variable "ingress_controller_namespace" {}
variable "ingress_namespace" {}
variable "ingress_repository" {}
variable "ingress_chart" {}
variable "ingress_create_namespace" {}