terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.0.0"
    }
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(local.service_account_path)
}
