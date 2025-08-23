resource "google_compute_network" "vpc_network" {
  name                    = "${local.prefix}-vpc"
  description             = "VPC network for the ${var.environment} environment managed by ${var.team} team"
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name                     = "${local.prefix}-subnet"
  description              = "Subnetwork 1 in the ${var.environment} environment managed by ${var.team} team"
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  project                  = var.project_id
  ip_cidr_range            = var.subnet_ip_range
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "kubernetes-pods-range"
    ip_cidr_range = var.pods_ip_range
  }

  secondary_ip_range {
    range_name    = "kubernetes-services-range"
    ip_cidr_range = var.services_ip_range
  }

  depends_on = [google_compute_network.vpc_network]
}

