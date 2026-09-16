variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "asia-south1-b"
}

variable "machine_type" {
  description = "Compute Engine machine type"
  type        = string
  default     = "e2-medium"
}

variable "vm_name" {
  description = "Name of the Terraform-created VM"
  type        = string
  default     = "project12-app-vm"
}

