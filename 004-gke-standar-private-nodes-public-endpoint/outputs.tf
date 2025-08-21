output "prefix" {
  description = "The prefix used for naming resources in the dev environment."
  value       = local.prefix
}

output "backend_path" {
  description = "The path for the backend bucket in the dev environment."
  value       = local.backend_path
}

output "gke_service_account_email" {
  description = "The email of the GKE service account."
  value       = google_service_account.gke_nodepool_sa.email
}

output "gke_cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.gke_cluster.name
}

output "gke_cluster_location" {
  description = "The location of the GKE cluster."
  value       = google_container_cluster.gke_cluster.location
}

output "gke_cluster_endpoint" {
  description = "The endpoint of the GKE cluster."
  value       = google_container_cluster.gke_cluster.endpoint
}

output "gke_cluster_master_version" {
  description = "The master version of the GKE cluster."
  value       = google_container_cluster.gke_cluster.master_version
}

output "gke_cluster_node_version" {
  description = "The node version of the GKE cluster."
  value       = google_container_cluster.gke_cluster.node_version
}

output "gke_node_pool_name" {
  description = "The name of the GKE node pool."
  value       = google_container_node_pool.gke_node_pool.name
}

output "gke_node_pool_location" {
  description = "The location of the GKE node pool."
  value       = google_container_node_pool.gke_node_pool.location
}

output "gke_node_pool_initial_node_count" {
  description = "The initial node count of the GKE node pool."
  value       = google_container_node_pool.gke_node_pool.initial_node_count
}

output "gke_node_pool_machine_type" {
  description = "The machine type of the GKE node pool."
  value       = google_container_node_pool.gke_node_pool.node_config[0].machine_type
}

output "gke_node_pool_version" {
  description = "The version of the GKE node pool."
  value       = google_container_node_pool.gke_node_pool.version
}

output "gke_available_zones" {
  description = "values of available zones in the project"
  value       = data.google_compute_zones.available_zones.names
}
