locals {
  prefix                      = "${var.project}-${var.environment}-${var.team}"
  service_account_path        = "${path.module}/../../markitos-es-nogit/markitos-es-terraform-sa.json"
  network_ssh_tags            = [for tag in var.network_ssh_tags : "${local.prefix}-${tag}"]
  deletion_cluster_protection = var.environment == "prod" ? true : false
  cluster_zone_location       = data.google_compute_zones.available_zones.names[0]
  cluster_node_locations      = [for z in data.google_compute_zones.available_zones.names : z if z != data.google_compute_zones.available_zones.names[0]]

  common_tags = {
    "prefix"      = local.prefix
    "project"     = var.project
    "project_gcp" = var.project_id
    "environment" = var.environment
    "team"        = var.team
  }
}
