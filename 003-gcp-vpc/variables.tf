variable "credentials_file_path" {
  description = "Relative path to the GCP service account credentials JSON file from project root"
  type        = string
  default     = "/path/to/key.json"
}

variable "project_identifier" {
  description = "Google Cloud Platform project unique identifier"
  type        = string
  default     = "markitos-terraform"
}

variable "project_name" {
  description = "Proyect name for prefix of resources"
  type        = string
  default     = "markitos-tf-gcp"
}

variable "deployment_region" {
  description = "Google Cloud Platform region where resources will be deployed"
  type        = string
  default     = "us-central1"
}

variable "deployment_zone" {
  description = "Google Cloud Platform availability zone within the specified region"
  type        = string
  default     = "us-central1-a"
}

variable "environment_target" {
  description = "Current target environment for resource deployment (required)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod", "pre", "staging", "qa"], var.environment_target)
    error_message = "Environment target must be one of: dev, prod, pre, staging, qa"
  }
}

variable "resource_creator_information" {
  description = "Information about the creator of the infrastructure resources"
  type        = string
  default     = "Marco Antonio - markitos - DevsecopsKulture"
}
