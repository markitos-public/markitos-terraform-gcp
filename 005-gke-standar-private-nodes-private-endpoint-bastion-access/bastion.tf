resource "google_compute_address" "bastion_internal_ip_address" {
  name         = "${local.prefix}-internal-bastion-ip"
  description  = "Internal IP address for the bastion host"
  address_type = "INTERNAL"
  region       = var.region
  subnetwork   = google_compute_subnetwork.subnet.id
  address      = local.bastion_internal_ip_address
}

resource "google_compute_instance" "bastion" {
  name         = "${local.prefix}-bastion"
  machine_type = "e2-micro"
  zone         = var.bastion_zone
  project      = var.project_id
  tags         = local.network_ssh_tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network_ip = google_compute_address.bastion_internal_ip_address.address
    subnetwork = google_compute_subnetwork.subnet.id
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    sudo apt update
    sudo apt install -y google-cloud-sdk-gke-gcloud-auth-plugin kubectl telnet
    sudo apt update
    sudo apt install -y gnupg software-properties-common
  EOT
}
