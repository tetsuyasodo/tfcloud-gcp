output "subnet01" {
  value = google_compute_subnetwork.subnet01.self_link
}

output "elastic_network" {
  value = google_compute_network.elastic_network.self_link
}
