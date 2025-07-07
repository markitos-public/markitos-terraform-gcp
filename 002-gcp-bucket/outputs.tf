output "bucket_name" {
  description = "The name of the created bucket"
  value       = google_storage_bucket.terraform_bucket_example.name
}

output "bucket_url" {
  description = "The URL of the created bucket"
  value       = google_storage_bucket.terraform_bucket_example.self_link
}
