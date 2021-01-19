output "bastion-ip" {
  value = google_compute_instance.bastion.network_interface.0.access_config.0.nat_ip
}

output "mon-ip" {
  value = google_compute_instance.mon01.network_interface.0.access_config.0.nat_ip
}

output "kb01-ip" {
  value = google_compute_instance.kb01.network_interface.0.access_config.0.nat_ip
}
