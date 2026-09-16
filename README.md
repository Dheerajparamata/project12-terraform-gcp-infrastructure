# Project 12 — Terraform Infrastructure as Code on Google Cloud

## Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform to provision and configure infrastructure on Google Cloud Platform (GCP).

Terraform automatically creates a custom VPC network, subnet, firewall rule, and Compute Engine VM. The VM uses a startup script to install Docker and deploy an Nginx web server.

## Architecture

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

- Custom VPC: `project12-vpc`
- Subnet: `project12-subnet`
- CIDR: `10.10.0.0/24`
- HTTP Firewall Rule: `project12-vpc-allow-http`
- Compute Engine VM: `project12-app-vm`
- Machine Type: `e2-medium`
- Zone: `asia-south1-b`
- Boot Disk: 20 GB
- Operating System: Debian 12
- Docker container: `project12-nginx`
- Nginx port: `80`

## Terraform Workflow

```bash
terraform init
terraform validate
terraform plan
terraform apply
