output "bastion-ip" {
  count = length(var.users)
  value = google_compute_instance.bastion[count.index].network_interface.0.access_config.0.nat_ip
}

output "mon-ip" {
  count = length(var.users)
  value = google_compute_instance.mon01[count.index].network_interface.0.access_config.0.nat_ip
}

output "kb01-ip" {
  count = length(var.users)
  value = google_compute_instance.kb01[count.index].network_interface.0.access_config.0.nat_ip
}
