resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  numeric = false
  upper   = false
  lower   = true
}
