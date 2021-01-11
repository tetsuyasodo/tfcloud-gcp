resource "google_compute_instance" "bastion" {
  count = length(var.users)
  name         = "bastion-${var.users[count.index]}"
  machine_type = var.machine_type["bastion"]
  zone         = "asia-northeast1-a"
  tags = ["bastion"]

  boot_disk {
    initialize_params {
      size = 20
      type = "pd-standard"
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    subnetwork = var.subnet

    access_config {
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  metadata = {
    ssh-keys = "${var.users[count.index]}:${file("./pubkeys/id_rsa-${var.users[count.index]}.pub")}"
    #startup-script = file("./scripts/install_bastion.sh")
  }
  
}

