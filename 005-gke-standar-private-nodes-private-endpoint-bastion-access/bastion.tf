resource "google_compute_instance" "bastion" {
  name         = "${local.prefix}-bastion"
  machine_type = "e2-micro"
  zone        = var.zone
  project     = var.project_id

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    access_config {
    }
  }
}
