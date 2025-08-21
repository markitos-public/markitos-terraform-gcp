output "environment_deployment_target" {
  description = "The target environment where resources are deployed"
  value       = var.environment_target
}

output "resource_creator_information" {
  description = "Information about the creator of the infrastructure resources"
  value       = var.resource_creator_information
}

output "project_identifier" {
  description = "Google Cloud Platform project identifier used for resource deployment"
  value       = var.project_identifier
}

output "project_name" {
  description = "Project name used as a prefix for resources"
  value       = var.project_name
}

output "deployment_region" {
  description = "Google Cloud Platform region where resources are deployed"
  value       = var.deployment_region
}
