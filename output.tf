output "kubernetes_cluster_host" {
  value       = google_container_cluster.primary.*.endpoint
  description = "GKE Cluster Host"
}

output "gke-k8s-creds" {
      value = [
    for gkecl in google_container_cluster.primary : "gcloud container clusters get-credentials ${gkecl.name} --zone=${var.region}"
  ]
}