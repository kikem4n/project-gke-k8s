resource "google_compute_network" "gke_vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  routing_mode            = var.routing_mode
}

resource "google_compute_subnetwork" "gke_subnets" {
  name          = "${var.subnet_name}-subnet"
  ip_cidr_range = var.ip_cidr_block
  region        = var.region
  network       = google_compute_network.gke_vpc.id
}