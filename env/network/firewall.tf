resource "google_compute_firewall" "bastion" {
  name    = "bastion"
  network = google_compute_network.elastic_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["bastion"]
}

resource "google_compute_firewall" "from_bastion" {
  name    = "from-bastion"
  network = google_compute_network.elastic_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion"]
  target_tags = ["from-bastion"]
}

resource "google_compute_firewall" "elastic_network_allow_kibana" {
  name    = "elastic-network-allow-kibana"
  network = google_compute_network.elastic_network.self_link

  allow {
    protocol = "tcp"
    ports    = ["5601"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["kibana"]
}

resource "google_compute_firewall" "elastic_network_allow_within_elastic" {
  name    = "elastic-network-allow-within-elastic"
  network = google_compute_network.elastic_network.self_link

  allow {
    protocol = "tcp"
  }

  source_tags = ["elastic"]
  target_tags = ["elastic"]
}
