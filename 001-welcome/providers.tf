terraform {
  required_version = "~> 1.12.2"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.41.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file_path)
  project     = var.project_identifier
  region      = var.deployment_region
  zone        = var.deployment_zone
}

