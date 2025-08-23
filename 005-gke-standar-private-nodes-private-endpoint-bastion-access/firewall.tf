resource "google_compute_firewall" "firewall_rules" {
  description = "Default firewall rules for the ${var.environment} environment managed by ${var.team} team"
  name        = "${local.prefix}-allow-ssh"
  network     = google_compute_network.vpc_network.id
  project     = var.project_id

  allow {
    protocol = "tcp"
    ports    = var.firewall_ports
  }

  source_ranges = var.iap_source_ranges
  target_tags   = local.network_ssh_tags
  direction     = "INGRESS"
  priority      = 1000
}
