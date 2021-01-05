resource "google_compute_subnetwork" "pub_subnetwork" {
  name          = "sample-subnet-pub"
  ip_cidr_range = "192.168.1.0/24"
  region        = "asia-northeast1"
  network       = "sample-network"
  depends_on    = [google_compute_network.sample_network]
}

resource "google_compute_subnetwork" "prv_subnetwork" {
  name          = "sample-subnet-prv"
  ip_cidr_range = "10.0.1.0/24"
  region        = "asia-northeast3"
  network       = "sample-network"
  depends_on    = [google_compute_network.sample_network]
}

resource "google_compute_subnetwork" "prv_subnetwork2" {
  name          = "sample-subnet-prv2"
  ip_cidr_range = "10.0.2.0/24"
  region        = "asia-northeast3"
  network       = "sample-network"
  depends_on    = [google_compute_network.sample_network]
}
