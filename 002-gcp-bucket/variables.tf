variable "gcp_credentials_file" {
  description = "Path to the GCP credentials JSON file"
  type        = string
  default     = "../000-assets/key.json"
}

variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "terraform-markitos"
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

variable "gcp_bucket_name" {
  description = "GCP bucket name"
  type        = string
  default     = "terraform-markitos-bucket"
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    iactool     = "terraform"
    creator     = "markitos"
    environment = "development"
  }
}

variable "gcp_instance_type" {
  description = "GCP instance type"
  type        = string
  default     = "e2-micro"
}

variable "gcp_storage_class" {
  description = "GCP storage class for the bucket"
  type        = string
  default     = "STANDARD"
}
