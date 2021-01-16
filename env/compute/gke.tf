resource "google_container_cluster" "eckcluster" {
  name     = "eckcluster01"
  location = "asia-northeast1-a"

  #remove_default_node_pool = true
  initial_node_count       = 3

  network = "elastic-network"
  subnetwork = var.subnet

  min_master_version = "1.16"
  node_version       = "1.16"

  node_config {
    metadata = {
      disable-legacy-endpoints = "true"
    }
    machine_type = "e2-standard-4"
    #machine_type = "e2-small"
    #tags = ["from-bastion", "elastic", "kibana"]
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
