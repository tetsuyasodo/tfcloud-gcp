resource "google_compute_instance" "es01" {
  count = length(var.users)
  name         = "es01-${var.users[count.index]}"
  machine_type = var.machine_type["elasticsearch"]
  zone         = "asia-northeast1-a"
  tags = ["from-bastion", "elastic"]

  boot_disk {
    initialize_params {
      size = 40
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
    startup-script = file("./scripts/install_es.sh")
  }
}

resource "google_compute_instance" "es02" {
  count = length(var.users)
  name         = "es02-${var.users[count.index]}"
  machine_type = var.machine_type["elasticsearch"]
  zone         = "asia-northeast1-a"
  tags = ["from-bastion", "elastic"]

  boot_disk {
    initialize_params {
      size = 40
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
    startup-script = file("./scripts/install_es.sh")
  }
}

resource "google_compute_instance" "es03" {
  count = length(var.users)
  name         = "es03-${var.users[count.index]}"
  machine_type = var.machine_type["elasticsearch"]
  zone         = "asia-northeast1-a"
  tags = ["from-bastion", "elastic"]

  boot_disk {
    initialize_params {
      size = 40
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
    startup-script = file("./scripts/install_es.sh")
  }
}
