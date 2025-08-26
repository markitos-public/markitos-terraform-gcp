resource "google_compute_router" "router" {
  name    = "${local.prefix}-${local.region}-router"
  region  = local.region
  network = google_compute_network.vpc_network.self_link

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_router_nat" "nat" {
  name   = "${local.prefix}-${var.region}-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

  depends_on = [google_compute_router.router]
}
