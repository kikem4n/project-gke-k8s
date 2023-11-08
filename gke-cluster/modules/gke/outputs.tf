output "cluster_name" {
  value = google_container_cluster.gke_cluster.name
}
output "cluster_endpoint" {
  value = google_container_cluster.gke_cluster.endpoint
}
output "cluster_ca_certificate" {
  value = google_container_cluster.gke_cluster.master_auth.0.cluster_ca_certificate
}
output "cluster_access_token" {
  value = data.google_client_config.gke_client_config.access_token
}