resource "google_compute_network" "elastic_network" {
  name                    = "elastic-network"
  auto_create_subnetworks = false
}
