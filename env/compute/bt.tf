resource "google_compute_instance" "bt01" {
  count = length(var.users)
  name         = "bt01-${var.users[count.index]}"
  machine_type = var.machine_type["beats"]
  zone         = "asia-northeast1-a"
  tags = ["from-bastion", "elastic"]

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
    startup-script = file("./scripts/install_bt.sh")
  }
}
