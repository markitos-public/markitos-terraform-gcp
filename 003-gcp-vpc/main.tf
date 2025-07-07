locals {
  environment = var.environment_target
  creator     = var.resource_creator_information
  managed_by  = "terraform env: ${var.environment_target}"
  region      = var.deployment_region
  project     = var.project_identifier
  prefix      = var.project_name
}

resource "google_compute_network" "default" {
  name                    = "${local.prefix}-network"
  description             = "VPC network for example project"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
  name          = "${local.prefix}-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  region        = local.region
  network       = google_compute_network.default.id
}

resource "google_compute_firewall" "default" {
  name    = "${local.prefix}-firewall"
  network = google_compute_network.default.id

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["10.0.1.0/24"]
  target_tags   = ["allow-ssh", "allow-http", "allow-https"]
  description   = "Allow SSH, HTTP, and HTTPS traffic"
  priority      = 1000
  direction     = "INGRESS"
}
