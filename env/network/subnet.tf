resource "google_compute_subnetwork" "subnet01" {
  name          = "elastic-subnet01"
  ip_cidr_range = "10.0.0.0/24"
  region        = "asia-northeast1"
  network       = google_compute_network.elastic_network.self_link
}

