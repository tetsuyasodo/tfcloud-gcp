resource "google_compute_subnetwork" "pub_subnetwork" {
  name          = "sample-subnet-pub"
  ip_cidr_range = "192.168.1.0/24"
  region        = "asia-northeast1"
  network       = "sample-network"
}

resource "google_compute_subnetwork" "prv_subnetwork" {
  name          = "sample-subnet-prv"
  ip_cidr_range = "10.0.1.0/24"
  region        = "asia-northeast3"
  network       = "sample-network"
}
