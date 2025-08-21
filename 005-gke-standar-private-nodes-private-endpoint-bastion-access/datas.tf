data "google_compute_zones" "available_zones" {
  region = var.region
  status = "UP"
}
