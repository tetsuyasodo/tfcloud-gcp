resource "google_compute_instance" "kb01" {
  count = length(var.users)
  name         = "kb01-${var.users[count.index]}"
  machine_type = var.machine_type["kibana"]
  zone         = "asia-northeast1-a"
  tags = ["from-bastion", "elastic", "kibana"]

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
    #ssh-keys = "${element(var.users, count.index)}:${file("./pubkeys/id_rsa-${element(var.users, count.index)}.pub")}"
    ssh-keys = "${var.users[count.index]}:${file("./pubkeys/id_rsa-${var.users[count.index]}.pub")}"
    startup-script = file("./scripts/install_kb.sh")
  }
}

