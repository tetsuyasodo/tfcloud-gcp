resource "google_compute_network" "sample_network" {
  name                    = "sample-network"
  auto_create_subnetworks = false
}
