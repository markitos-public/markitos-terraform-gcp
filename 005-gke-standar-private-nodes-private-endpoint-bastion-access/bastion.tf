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
    sudo apt install -y google-cloud-sdk-gke-gcloud-auth-plugin kubectl unzip
    sudo apt update
    sudo apt install -y gnupg software-properties-common
    echo "Instalando Terraform 1.12.2 en ~/.local/bin ..."
    mkdir -p ~/.local/bin
    wget https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip -O /tmp/terraform.zip
    unzip -o /tmp/terraform.zip -d ~/.local/bin
    chmod +x ~/.local/bin/terraform
    rm /tmp/terraform.zip
    echo "Terraform instalado correctamente en ~/.local/bin"
    echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc && source ~/.bashrc && echo "All done!"
  EOT
}
