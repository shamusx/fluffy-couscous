variable "num_nodes" {
  default     = 2
  description = "number of nodes"
}

variable "project_id" {
    default = "gcloud config get-value project"
}

variable "region" {
    default = "us-central1"
}

variable "min_k8_version" {
    default = "1.21"
}

variable "num_of_clusters" {
    default = 1
}

variable "machine_type" {
    default = "n1-standard-1"
}