resource "google_container_cluster" "gke01" {
  count = length(var.users)
  name     = "gke01-${var.users[count.index]}"
  location = "asia-northeast1-a"

  #remove_default_node_pool = true
  initial_node_count       = 3

  network = var.network
  subnetwork = var.subnet

  min_master_version = "1.16"
  node_version       = "1.16"

  node_config {
    metadata = {
      disable-legacy-endpoints = "true"
    }
    machine_type = var.machine_type["gke"]
    tags = ["from-bastion", "elastic"]
  }

  master_auth {
    username = "admin"
    password = "P@ssw0rdP@ssw0rd"

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

