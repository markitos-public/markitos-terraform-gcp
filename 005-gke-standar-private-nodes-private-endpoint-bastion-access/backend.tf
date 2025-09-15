terraform {
  backend "gcs" {
    bucket = "markitos-es-terraform-states"
    prefix = "dev/markitos-es-gcp-infrastructure"
  }
}