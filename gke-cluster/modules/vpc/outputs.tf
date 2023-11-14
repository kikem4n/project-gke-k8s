output "vpc_id" {
  value = google_compute_network.gke_vpc.id
}

output "subnetwork_id" {
  value =  google_compute_subnetwork.gke_subnets.id
}