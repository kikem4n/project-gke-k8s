output "add_to_kubeconfig" {
  value = "gcloud container clusters get-credentials ${module.gke.cluster_name} --zone ${var.zone}"
}
