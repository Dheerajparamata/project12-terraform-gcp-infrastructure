terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# VPC Network
resource "google_compute_network" "project12_vpc" {
  name                    = "project12-vpc"
  auto_create_subnetworks = false
}

# Subnet
resource "google_compute_subnetwork" "project12_subnet" {
  name          = "project12-subnet"
  region        = var.region
  network       = google_compute_network.project12_vpc.id
  ip_cidr_range = "10.10.0.0/24"
}

# Firewall Rule - Allow HTTP
resource "google_compute_firewall" "allow_http" {
  name    = "project12-vpc-allow-http"
  network = google_compute_network.project12_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
# Compute Engine VM
resource "google_compute_instance" "project12_app_vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network    = google_compute_network.project12_vpc.id
    subnetwork = google_compute_subnetwork.project12_subnet.id

    access_config {
      # Ephemeral public IP
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io
    systemctl enable docker
    systemctl start docker
    docker run -d --name project12-nginx -p 80:80 nginx:latest
  EOF

  tags = ["project12-web"]
}
output "vm_public_ip" {
  description = "Public IP address of the Terraform-created VM"
  value       = google_compute_instance.project12_app_vm.network_interface[0].access_config[0].nat_ip
}
