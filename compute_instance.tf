resource "google_compute_instance" "bastion" {
  name         = "bastion"
  machine_type = "n1-standard-1"
  zone         = "asia-northeast1-a"
  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.pub_subnetwork.self_link

    access_config {
      nat_ip = google_compute_address.bastion_external.address
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }
  
  metadata {
    startup-script = "${file("bastion-test.sh")}"
  }
  
}

resource "google_compute_address" "bastion_external" {
  name         = "bastion-external"
  address_type = "EXTERNAL"
  region       = "asia-northeast1"
}

resource "google_compute_instance" "web_instance" {
  name         = "web-instance"
  machine_type = "n1-standard-1"
  zone         = "asia-northeast3-a"
  tags = ["from-bastion", "http-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.prv_subnetwork.self_link

    # access_config {
    #   nat_ip = google_compute_address.bastion_external.address
    # }
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}
