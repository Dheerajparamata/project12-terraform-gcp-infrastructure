# Project 12 — Terraform Infrastructure as Code on Google Cloud

## Overview

This project demonstrates **Infrastructure as Code (IaC)** using Terraform to provision and configure infrastructure on **Google Cloud Platform (GCP)**.

Terraform automatically creates a custom VPC network, subnet, firewall rule, and Compute Engine VM. The VM uses a startup script to install Docker and deploy an Nginx web server.

## Architecture

```text
Terraform
    ↓
Google Cloud
    ↓
VPC Network
    ↓
Subnet
    ↓
Firewall Rule
    ↓
Compute Engine VM
    ↓
Docker
    ↓
Nginx Web Application
```

## Technologies Used

- Terraform
- Google Cloud Platform (GCP)
- Compute Engine
- VPC Network
- Google Cloud Firewall
- Docker
- Nginx
- Debian 12
- Git/GitHub

## Infrastructure Created

- **Custom VPC:** `project12-vpc`
- **Subnet:** `project12-subnet`
- **CIDR:** `10.10.0.0/24`
- **HTTP Firewall Rule:** `project12-vpc-allow-http`
- **Compute Engine VM:** `project12-app-vm`
- **Machine Type:** `e2-medium`
- **Zone:** `asia-south1-b`
- **Boot Disk:** 20 GB
- **Operating System:** Debian 12
- **Docker Container:** `project12-nginx`
- **Nginx Port:** `80`

## Terraform Workflow

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Review the infrastructure plan:

```bash
terraform plan
```

Create the infrastructure:

```bash
terraform apply
```

Retrieve the VM public IP:

```bash
terraform output
```

## Application Deployment

The Compute Engine VM uses a Terraform startup script to:

1. Update the Debian package repository.
2. Install Docker.
3. Enable and start the Docker service.
4. Pull the Nginx Docker image.
5. Run the Nginx container on port `80`.

The Nginx application was successfully verified through the VM's public IP.

## Project Structure

```text
project12-terraform-gcp-infrastructure/
│
├── main.tf
├── variables.tf
├── .terraform.lock.hcl
├── .gitignore
└── README.md
```

Terraform state files and sensitive variable files are excluded from Git using `.gitignore`.

## Learning Outcomes

- Understanding Infrastructure as Code
- Provisioning GCP infrastructure using Terraform
- Creating and managing VPC networks and subnets
- Configuring GCP firewall rules
- Provisioning Compute Engine resources
- Using Terraform variables and outputs
- Automating VM configuration with startup scripts
- Deploying Docker containers automatically
- Deploying Nginx as a containerized web application
- Managing infrastructure code with Git and GitHub

## Project Status

**Status: Completed ✅**

Terraform successfully provisioned the GCP infrastructure, deployed Docker and Nginx automatically, and the Nginx web application was successfully accessed through the VM's public IP.
