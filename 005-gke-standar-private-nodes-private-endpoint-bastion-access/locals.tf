locals {
  prefix                      = "${var.project}-${var.environment}-${var.team}"
  region                      = var.region
  service_account_path        = "${path.module}/../000-nogit/markitos-es-terraform-sa.json"
  network_ssh_tags            = [for tag in var.network_ssh_tags : "${local.prefix}-${tag}"]
  deletion_cluster_protection = var.environment == "prod" ? true : false
  cluster_zone_location       = data.google_compute_zones.available_zones.names[0]
  cluster_node_locations      = [for z in data.google_compute_zones.available_zones.names : z if z != data.google_compute_zones.available_zones.names[0]]
  bastion_internal_ip_address = var.bastion_internal_ip_address
  bastion_internal_ip_range   = "${local.bastion_internal_ip_address}/32"

  common_tags = [
    var.project,
    var.project_id,
    var.environment,
    var.team
  ]
}
