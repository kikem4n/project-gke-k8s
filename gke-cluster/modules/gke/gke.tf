data "google_client_config" "gke_client_config" {}
data "google_container_engine_versions" "gke_kubernetes_version" {
  location       = var.region
  version_prefix = "1.27."
}

resource "google_container_cluster" "gke_cluster" {
  name                     = var.cluster_name
  location                 = var.regional ? var.region : var.zone
  initial_node_count       = var.initial_node_count
  remove_default_node_pool = true
  network                  = var.vpc_id
  subnetwork               = var.subnetwork_id
  deletion_protection      = false
  node_locations           = var.node_locations
}

resource "google_container_node_pool" "gke_nodes" {
  location   = var.regional ? var.region : var.zone
  name       = google_container_cluster.gke_cluster.name
  cluster    = google_container_cluster.gke_cluster.id
  node_count = var.gke_nodes

  node_config {
    oauth_scopes = var.oauth_scopes
    labels = {
      env = var.project_id
    }
    disk_size_gb = var.disk_size_gb
    machine_type = var.machine_type
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}