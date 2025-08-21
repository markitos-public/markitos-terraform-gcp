output "environment_deployment_target" {
  description = "The target environment where resources are deployed"
  value       = var.environment_target
}

output "resource_creator_information" {
  description = "Information about the creator of the infrastructure resources"
  value       = var.resource_creator_information
}

output "group_category" {
  description = "Category or functional area of the resource group being deployed"
  value       = var.group_category
}

output "standardized_resource_tags" {
  description = "Standardized tags applied to all resources for consistent labeling"
  value       = local.standardized_resource_tags
}

output "resource_unique_suffix" {
  description = "Unique suffix generated for resource naming to avoid conflicts"
  value       = random_string.resource_unique_suffix.result
}

output "project_identifier" {
  description = "Google Cloud Platform project identifier used for resource deployment"
  value       = var.project_identifier
}

output "deployment_region" {
  description = "Google Cloud Platform region where resources are deployed"
  value       = var.deployment_region
}
