variable "credentials_file_path" {
  description = "Relative path to the GCP service account credentials JSON file from project root"
  type        = string
  default     = "./key.json"
}

variable "project_identifier" {
  description = "Google Cloud Platform project unique identifier"
  type        = string
  default     = "terraform-markitos"
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

variable "group_category" {
  description = "Category or functional area of the resource group being deployed (required)"
  type        = string
  validation {
    condition     = can(regex("^[a-z]{3,25}$", var.group_category))
    error_message = "Group category must contain only lowercase letters (a-z) and be between 3-25 characters long"
  }
}
