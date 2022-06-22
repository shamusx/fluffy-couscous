# GKE cluster
resource "google_container_cluster" "primary" {
  count = var.num_of_clusters
  name     = "${var.project_id}-${count.index + 1}-gke"
  location = var.region
  min_master_version = var.min_k8_version

  remove_default_node_pool = true
  initial_node_count       = 1
  
  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

# Separately Managed Node Pool
resource "google_container_node_pool" "primary_nodes" {
  count = var.num_of_clusters
  name       = "${google_container_cluster.primary[count.index].name}-${count.index + 1}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary[count.index].name
  node_count = var.num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    # preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}