locals {
  bucket_name          = "${var.gcp_bucket_name}-${random_string.bucket_suffix.result}"
  bucket_region        = var.gcp_region
  bucket_storage_class = var.gcp_storage_class
  bucket_purpose       = "remote-bucket-for-state-files"
  bucket_labels = merge(
    var.common_tags,
    {
      name    = local.bucket_name
      purpose = local.bucket_purpose
    }
  )
}

resource "google_storage_bucket" "terraform_bucket_example" {
  name                        = local.bucket_name
  location                    = local.bucket_region
  storage_class               = local.bucket_storage_class
  force_destroy               = false
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }

  labels = local.bucket_labels
}
