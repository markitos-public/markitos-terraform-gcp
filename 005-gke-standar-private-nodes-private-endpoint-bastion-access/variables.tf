#:[.'.]:>- --------------------------------------------------
#:[.'.]:>- GCP Variables for Terraform Configuration
#:[.'.]:>- --------------------------------------------------
variable "region" {
  description = "The GCP region where the resources will be deployed."
  type        = string
  default     = "us-central1"
}

variable "project_id" {
  description = "The GCP project ID where the resources will be created."
  type        = string
  default     = "markitos-es-gcp-infrastructure"
}

variable "project" {
  description = "The name of the project."
  type        = string
  default     = "markitos-es"
}

variable "environment" {
  description = "The environment for which the resources are being created (e.g., dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "team" {
  description = "The team responsible for the resources."
  type        = string
  default     = "devops"
}
#:[.'.]:>- --------------------------------------------------


#:[.'.]:>- --------------------------------------------------
#:[.'.]:>- Network Variables
#:[.'.]:>- --------------------------------------------------
variable "network_ssh_tags" {
  description = "List of tags to apply to the sshed hosts resources."
  type        = list(string)
  default     = ["ssh-host"]
}

variable "firewall_ports" {
  description = "List of ports to allow in the firewall rules."
  type        = list(string)
  default     = ["22"]
}
#:[.'.]:>- --------------------------------------------------


#:[.'.]:>- --------------------------------------------------
#:[.'.]:>- GKE Private Cluster Variables
#:[.'.]:>- --------------------------------------------------
variable "subnet_ip_range" {
  description = "The IP range for the subnet in CIDR notation."
  type        = string
  default     = "10.10.0.0/16"
}

variable "pods_ip_range" {
  description = "The IP range for the pods in CIDR notation."
  type        = string
  default     = "10.1.0.0/21"
}

variable "services_ip_range" {
  description = "The IP range for the services in CIDR notation."
  type        = string
  default     = "10.2.0.0/21"
}

variable "master_ip_range" {
  description = "The IP range for the master in CIDR notation."
  type        = string
  default     = "10.3.0.0/28"
}

variable "iap_source_ranges" {
  description = "List of source ranges for Identity-Aware Proxy (IAP) access."
  type        = list(string)
  default     = ["35.235.240.0/20"]
}

variable "bastion_zone" {
  description = "The zone where the bastion host will be deployed."
  type        = string
  default     = "us-central1-a"
}

variable "bastion_internal_ip_address" {
  description = "The internal IP address for the bastion host."
  type        = string
  default     = "10.10.10.10"
}
#:[.'.]:>- --------------------------------------------------
