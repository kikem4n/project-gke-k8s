output "add_to_kubeconfig" {
  value = var.regional ? "gcloud container clusters get-credentials ${module.gke.cluster_name} --region ${var.region}" : "gcloud container clusters get-credentials ${module.gke.cluster_name} --zone ${var.zone}"
}