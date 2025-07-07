locals {
  standardized_resource_tags = {
    environment = var.environment_target
    creator     = var.resource_creator_information
    category    = var.group_category
    managed_by  = "terraform"
    project     = var.project_identifier
  }
}

resource "random_string" "resource_unique_suffix" {
  length  = 8
  special = false
  upper   = false
  numeric = true
}

resource "null_resource" "hello_world_echo" {
  triggers = {
    environment = var.environment_target
    category    = var.group_category
    creator     = var.resource_creator_information
    timestamp   = timestamp()
  }

  provisioner "local-exec" {
    command = "echo 'Hello World from Terraform! Environment: ${var.environment_target}, Category: ${var.group_category}, Creator: ${var.resource_creator_information}'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroying Hello World resource...'"
  }
}
