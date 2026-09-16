# Project 12 — Terraform Infrastructure as Code on Google Cloud

![Terraform](https://img.shields.io/badge/Terraform-1.13.3-623CE4?logo=terraform&logoColor=white)
![Google Cloud](https://img.shields.io/badge/Google%20Cloud-GCP-4285F4?logo=googlecloud&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Web%20Server-009639?logo=nginx&logoColor=white)
![Debian](https://img.shields.io/badge/Debian-12-A81D33?logo=debian&logoColor=white)

## 📌 Overview

This project demonstrates **Infrastructure as Code (IaC)** using **Terraform** to provision and configure infrastructure on **Google Cloud Platform (GCP)**.

Instead of manually creating cloud resources through the GCP Console, Terraform is used to define the required infrastructure as code and deploy it automatically.

The project provisions a custom VPC network, subnet, firewall rule, and Compute Engine virtual machine. The VM uses a Terraform startup script to automatically install Docker and deploy an Nginx web server.

The final application can be accessed through the VM's public IP address.

---

## 🎯 Project Objectives

The main objectives of this project are:

- Learn Infrastructure as Code using Terraform.
- Provision Google Cloud infrastructure automatically.
- Create and manage a custom VPC network.
- Create a custom subnet.
- Configure an HTTP firewall rule.
- Provision a Compute Engine VM using Terraform.
- Automate VM configuration using a startup script.
- Install Docker automatically.
- Deploy Nginx inside a Docker container.
- Manage Terraform infrastructure through Git and GitHub.
- Demonstrate a complete automated cloud deployment workflow.

---

## 🏗️ Architecture

```text
                    ┌──────────────────┐
                    │     Terraform    │
                    │   Infrastructure │
                    │       as Code    │
                    └────────┬─────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │   Google Cloud      │
                  │       Platform      │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │   Custom VPC         │
                  │   project12-vpc      │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │   Subnet             │
                  │ project12-subnet     │
                  │ 10.10.0.0/24         │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │   Firewall Rule      │
                  │   TCP Port 80       │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │   Compute Engine    │
                  │   project12-app-vm  │
                  │     e2-medium       │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │       Docker        │
                  │                     │
                  │   project12-nginx   │
                  └──────────┬──────────┘
                             │
                             ▼
                  ┌─────────────────────┐
                  │       Nginx         │
                  │     Port 80         │
                  │                     │
                  │  Web Application    │
                  └─────────────────────┘
```

---

## ☁️ Google Cloud Infrastructure

The following resources are created using Terraform:

| Resource | Configuration |
|---|---|
| VPC Network | `project12-vpc` |
| Subnet | `project12-subnet` |
| CIDR Range | `10.10.0.0/24` |
| Region | `asia-south1` |
| Zone | `asia-south1-b` |
| Firewall | `project12-vpc-allow-http` |
| Protocol | TCP |
| Port | `80` |
| VM | `project12-app-vm` |
| Machine Type | `e2-medium` |
| Operating System | Debian 12 |
| Boot Disk | 20 GB |
| Container | `project12-nginx` |
| Web Server | Nginx |

---

## 🛠️ Technologies Used

### Infrastructure

- Terraform
- Google Cloud Platform
- Google Compute Engine
- Google VPC
- Google Cloud Firewall

### Containerization

- Docker
- Nginx

### Operating System

- Debian 12
- Linux

### Version Control

- Git
- GitHub

---

## 📁 Project Structure

```text
project12-terraform-gcp-infrastructure/
│
├── main.tf
├── variables.tf
├── .terraform.lock.hcl
├── .gitignore
└── README.md
```

### File Description

#### `main.tf`

Contains the main Terraform configuration, including:

- Terraform provider configuration
- GCP provider
- VPC network
- Subnet
- Firewall rule
- Compute Engine VM
- Docker installation
- Nginx container deployment
- Terraform output

#### `variables.tf`

Defines reusable Terraform variables such as:

- GCP project ID
- Region
- Zone
- Machine type
- VM name

#### `.terraform.lock.hcl`

Locks the Terraform provider version information to provide consistent provider installation.

#### `.gitignore`

Prevents Terraform state files, sensitive variable files, and local Terraform directories from being committed to Git.

#### `README.md`

Project documentation and implementation details.

---

# 🚀 Deployment Process

## 1. Install Terraform

Terraform was installed on a Debian 12 Google Cloud VM.

Verify the installation:

```bash
terraform --version
```

Example:

```text
Terraform v1.13.3
```

---

## 2. Create the Terraform Project

Create the project directory:

```bash
mkdir project12-terraform-gcp-infrastructure
```

Navigate into it:

```bash
cd project12-terraform-gcp-infrastructure
```

---

## 3. Configure Terraform Variables

The project uses variables for reusable infrastructure configuration.

Example:

```hcl
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
```

---

# 🌐 Infrastructure Configuration

## VPC Network

Terraform creates a custom VPC network:

```text
project12-vpc
```

Auto-created subnetworks are disabled so that the subnet can be explicitly managed by Terraform.

---

## Subnet

Terraform creates:

```text
project12-subnet
```

with:

```text
CIDR: 10.10.0.0/24
Region: asia-south1
```

---

## 🔥 Firewall Rule

A firewall rule allows HTTP traffic to the web server:

```text
project12-vpc-allow-http
```

Configuration:

```text
Protocol: TCP
Port: 80
Source: 0.0.0.0/0
```

This allows users to access the Nginx web application through the VM's public IP.

---

# 🖥️ Compute Engine VM

Terraform creates:

```text
project12-app-vm
```

Configuration:

```text
Machine Type: e2-medium
Zone: asia-south1-b
OS: Debian 12
Disk: 20 GB
Network: project12-vpc
Subnet: project12-subnet
```

An ephemeral public IP address is assigned to the VM.

---

# 🐳 Docker Automation

The VM uses a Terraform startup script.

The startup script performs the following operations:

```bash
apt-get update
apt-get install -y docker.io
systemctl enable docker
systemctl start docker
```

This means Docker is installed automatically when the VM starts.

No manual Docker installation is required.

---

# 🌐 Nginx Deployment

After Docker is installed, the startup script runs:

```bash
docker run -d --name project12-nginx -p 80:80 nginx:latest
```

This:

1. Downloads the Nginx image.
2. Creates a container named `project12-nginx`.
3. Runs the container in detached mode.
4. Maps port `80` on the VM to port `80` inside the container.

---

# ⚙️ Terraform Workflow

## Initialize Terraform

```bash
terraform init
```

This downloads the required Terraform provider.

---

## Validate Configuration

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

---

## Review Infrastructure Plan

```bash
terraform plan
```

Terraform displays the resources that will be created, modified, or destroyed.

Example:

```text
Plan: 4 to add, 0 to change, 0 to destroy.
```

---

## Deploy Infrastructure

```bash
terraform apply
```

Confirm the deployment by entering:

```text
yes
```

Terraform then creates the required Google Cloud resources.

---

# 📤 Terraform Outputs

The project exposes the VM public IP using a Terraform output:

```hcl
output "vm_public_ip" {
  description = "Public IP address of the Terraform-created VM"
  value       = google_compute_instance.project12_app_vm.network_interface[0].access_config[0].nat_ip
}
```

Retrieve the public IP:

```bash
terraform output
```

Example:

```text
vm_public_ip = "YOUR_VM_PUBLIC_IP"
```

The IP is generated dynamically and is not hard-coded in the repository.

---

# 🧪 Application Testing

After Terraform deployment, the application was tested using:

```bash
curl http://YOUR_VM_PUBLIC_IP
```

The server returned the Nginx welcome page:

```text
Welcome to nginx!
```

The web application was also successfully opened in a web browser through the VM's public IP address.

---

# 🔄 Infrastructure as Code Workflow

The complete workflow is:

```text
Write Terraform Configuration
          ↓
terraform init
          ↓
terraform validate
          ↓
terraform plan
          ↓
terraform apply
          ↓
GCP Infrastructure Created
          ↓
VM Startup Script Executes
          ↓
Docker Installed
          ↓
Nginx Container Started
          ↓
Public IP Generated
          ↓
Nginx Web Application Accessible
```

---

# 🔐 Security and Git Management

Terraform state files are excluded from Git because they can contain infrastructure information.

The following files are ignored:

```text
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
.terraform/
```

The Terraform provider lock file is committed:

```text
.terraform.lock.hcl
```

This helps maintain consistent provider versions across deployments.

---

# 📚 Learning Outcomes

Through this project, the following concepts were practiced:

- Infrastructure as Code
- Terraform fundamentals
- Terraform providers
- Terraform resources
- Terraform variables
- Terraform outputs
- Terraform state management
- Terraform plan and apply
- Google Cloud VPC networking
- Subnet configuration
- Firewall configuration
- Compute Engine provisioning
- Startup scripts
- Docker automation
- Containerized Nginx deployment
- Linux administration
- Git version control
- GitHub repository management

---

# 🎯 Key DevOps Concepts Demonstrated

This project demonstrates how infrastructure and application deployment can be automated together.

Instead of manually performing:

```text
Create VPC
↓
Create Subnet
↓
Create Firewall
↓
Create VM
↓
Install Docker
↓
Install Nginx
↓
Configure Web Server
```

Terraform automates the infrastructure provisioning process, while the VM startup script automates the application environment setup.

```text
                Infrastructure as Code
                         │
                         ▼
                    Terraform
                         │
             ┌───────────┴───────────┐
             ▼                       ▼
       Cloud Infrastructure      VM Configuration
             │                       │
             ▼                       ▼
        GCP Resources            Docker
                                     │
                                     ▼
                                   Nginx
                                     │
                                     ▼
                              Web Application
```

---

# 📸 Project Verification

The deployment was successfully verified through:

- Terraform apply
- Terraform output
- GCP Compute Engine VM
- Docker-based Nginx deployment
- HTTP connectivity test
- Browser-based Nginx web page

The final result displayed:

```text
Welcome to nginx!
```

---

# 🏁 Project Status

**Completed ✅**

Terraform successfully provisioned the Google Cloud infrastructure, configured the Compute Engine VM, installed Docker automatically, deployed Nginx, and exposed the web application through HTTP.

---

# 👨‍💻 Author

**Dheeraj Paramata**

GitHub:

`https://github.com/Dheerajparamata`

---

## ⭐ Project Summary

**Project:** Terraform Infrastructure as Code on Google Cloud

**Purpose:** Automate cloud infrastructure provisioning and containerized web application deployment using Terraform.

**Result:** A fully automated GCP infrastructure deployment running Nginx inside Docker on a Terraform-created Compute Engine VM.
