resource "google_service_account" "gke_nodepool_sa" {
  account_id   = "${local.prefix}-gke-sa"
  display_name = "GKE env: ${var.environment} team: ${var.team} Node Pool Service Account"
}

resource "google_container_cluster" "gke_cluster" {
  name       = "${local.prefix}-gke-cluster"
  location   = local.cluster_zone_location
  network    = google_compute_network.vpc_network.self_link
  subnetwork = google_compute_subnetwork.subnet.self_link

  deletion_protection      = local.deletion_cluster_protection
  remove_default_node_pool = true
  initial_node_count       = 1

  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = var.master_ip_range
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = google_compute_subnetwork.subnet.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.subnet.secondary_ip_range[1].range_name
  }

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "Master Authorized Network"
      cidr_block   = local.bastion_internal_ip_range
    }
  }

  depends_on = [google_compute_subnetwork.subnet]
}

resource "google_container_node_pool" "gke_node_pool" {
  name               = "${local.prefix}-gke-node-pool"
  location           = local.cluster_zone_location
  node_locations     = local.cluster_node_locations
  cluster            = google_container_cluster.gke_cluster.name
  initial_node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }


  node_config {
    preemptible     = true
    machine_type    = "e2-medium"
    tags            = local.common_tags
    service_account = google_service_account.gke_nodepool_sa.email
    disk_size_gb    = 20
    disk_type       = "pd-standard"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  depends_on = [
    google_container_cluster.gke_cluster,
    google_service_account.gke_nodepool_sa
  ]
}

