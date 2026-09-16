# Project 12 — Terraform Infrastructure as Code on Google Cloud

## 📌 Project Overview

This project demonstrates **Infrastructure as Code (IaC)** using **Terraform** to provision and configure infrastructure on **Google Cloud Platform (GCP)**.

Instead of manually creating cloud resources through the GCP Console, Terraform is used to define the infrastructure as code and automatically provision:

- Custom VPC Network
- Subnet
- Firewall Rule
- Compute Engine VM
- Public IP
- Docker
- Nginx Web Server

The Compute Engine VM uses a **Terraform startup script** to automatically install Docker and deploy an Nginx container.

---

## 🏗️ Architecture

```text
                    Terraform
                        │
                        ▼
                Google Cloud Platform
                        │
                        ▼
                  Custom VPC
                  project12-vpc
                        │
                        ▼
                Custom Subnet
               project12-subnet
                        │
             ┌──────────┴──────────┐
             │                     │
             ▼                     ▼
       Firewall Rule         Compute Engine VM
       TCP Port 80            project12-app-vm
                                   │
                                   ▼
                                Docker
                                   │
                                   ▼
                              Nginx Container
                                   │
                                   ▼
                              Port 80 / HTTP
                                   │
                                   ▼
                         🌐 Nginx Web Application
```

---

# 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| Google Cloud Platform | Cloud infrastructure |
| Compute Engine | Virtual machine |
| VPC | Network infrastructure |
| Subnet | Private IP network |
| Cloud Firewall | HTTP traffic control |
| Docker | Containerization |
| Nginx | Web server |
| Debian 12 | VM operating system |
| Git | Version control |
| GitHub | Source code repository |

---

# ☁️ Google Cloud Infrastructure

## VPC Network

Terraform creates a custom VPC:

```text
project12-vpc
```

The VPC uses:

```text
auto_create_subnetworks = false
```

This allows the subnet to be explicitly managed by Terraform.

### Screenshot

Add your GCP VPC screenshot here:

```text
screenshots/01-vpc-network.png
```

![Terraform GCP VPC](screenshots/01-vpc-network.png)

---

# 🌐 Subnet

Terraform creates the following subnet:

```text
Name:       project12-subnet
Region:     asia-south1
CIDR:       10.10.0.0/24
```

The subnet is attached to:

```text
project12-vpc
```

### Screenshot

```text
screenshots/02-subnet.png
```

![Project 12 Subnet](screenshots/02-subnet.png)

---

# 🔥 Firewall Rule

Terraform creates an HTTP firewall rule:

```text
Name: project12-vpc-allow-http
Protocol: TCP
Port: 80
Source: 0.0.0.0/0
```

This allows HTTP traffic to reach the Nginx web server.

### Screenshot

```text
screenshots/03-firewall.png
```

![Project 12 Firewall](screenshots/03-firewall.png)

---

# 💻 Compute Engine VM

Terraform provisions a Compute Engine VM with the following configuration:

| Configuration | Value |
|---|---|
| VM Name | `project12-app-vm` |
| Machine Type | `e2-medium` |
| Zone | `asia-south1-b` |
| Operating System | Debian 12 |
| Boot Disk | 20 GB |
| Disk Type | pd-balanced |
| Network | `project12-vpc` |
| Subnet | `project12-subnet` |
| HTTP | Port 80 |
| Public IP | Terraform generated |

### Screenshot

```text
screenshots/04-compute-engine-vm.png
```

![Project 12 Compute Engine VM](screenshots/04-compute-engine-vm.png)

---

# 🐳 Docker Deployment

The VM is automatically configured using the Terraform startup script.

Terraform installs Docker:

```bash
apt-get update
apt-get install -y docker.io
```

Then Docker is enabled and started:

```bash
systemctl enable docker
systemctl start docker
```

Finally, Terraform runs the Nginx container:

```bash
docker run -d --name project12-nginx -p 80:80 nginx:latest
```

This means Docker and Nginx are deployed automatically when the VM starts.

### Screenshot

Add a terminal screenshot showing Docker:

```text
screenshots/05-docker.png
```

![Docker running on Project 12 VM](screenshots/05-docker.png)

---

# 🌍 Nginx Web Application

The Nginx container listens on:

```text
Port 80
```

The application can be accessed through the VM's public IP.

Terraform provides the public IP using an output variable:

```bash
terraform output
```

Example:

```text
vm_public_ip = "<VM_PUBLIC_IP>"
```

The Nginx web page was successfully accessed through the public IP.

### Screenshot

Add your browser screenshot of the Nginx page:

```text
screenshots/06-nginx-web-page.png
```

![Nginx Web Application](screenshots/06-nginx-web-page.png)

---

# 🧩 Terraform Configuration

## Provider

Terraform uses the Google Cloud provider:

```hcl
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}
```

---

## Terraform Variables

The project uses variables for reusable configuration:

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

# 🚀 Terraform Workflow

## 1. Initialize Terraform

```bash
terraform init
```

This downloads the required Terraform provider.

### Screenshot

```text
screenshots/07-terraform-init.png
```

![Terraform Init](screenshots/07-terraform-init.png)

---

## 2. Validate Configuration

```bash
terraform validate
```

Expected result:

```text
Success! The configuration is valid.
```

### Screenshot

```text
screenshots/08-terraform-validate.png
```

![Terraform Validate](screenshots/08-terraform-validate.png)

---

## 3. Create an Execution Plan

```bash
terraform plan
```

Terraform displays the resources that will be created or modified.

Example:

```text
Plan: 1 to add, 0 to change, 0 to destroy.
```

### Screenshot

```text
screenshots/09-terraform-plan.png
```

![Terraform Plan](screenshots/09-terraform-plan.png)

---

## 4. Apply Infrastructure

```bash
terraform apply
```

Confirm with:

```text
yes
```

Terraform then provisions the required GCP resources.

Successful deployment:

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

### Screenshot

```text
screenshots/10-terraform-apply.png
```

![Terraform Apply](screenshots/10-terraform-apply.png)

---

# 📤 Terraform Output

The VM public IP is exposed using a Terraform output:

```hcl
output "vm_public_ip" {
  description = "Public IP address of the Terraform-created VM"
  value       = google_compute_instance.project12_app_vm.network_interface[0].access_config[0].nat_ip
}
```

Retrieve it using:

```bash
terraform output
```

Example:

```text
vm_public_ip = "<VM_PUBLIC_IP>"
```

### Screenshot

```text
screenshots/11-terraform-output.png
```

![Terraform Output](screenshots/11-terraform-output.png)

---

# 🧪 Application Testing

The Nginx application was tested using:

```bash
curl http://<VM_PUBLIC_IP>
```

The server returned the Nginx welcome page:

```text
Welcome to nginx!
```

This confirms that:

- The VM is running
- The firewall allows HTTP traffic
- Docker is running
- The Nginx container is running
- Port 80 is accessible
- The web application is working

### Screenshot

```text
screenshots/12-nginx-curl-test.png
```

![Nginx Curl Test](screenshots/12-nginx-curl-test.png)

---

# 📁 Project Structure

```text
project12-terraform-gcp-infrastructure/
│
├── main.tf
├── variables.tf
├── .terraform.lock.hcl
├── .gitignore
├── README.md
│
└── screenshots/
    ├── 01-vpc-network.png
    ├── 02-subnet.png
    ├── 03-firewall.png
    ├── 04-compute-engine-vm.png
    ├── 05-docker.png
    ├── 06-nginx-web-page.png
    ├── 07-terraform-init.png
    ├── 08-terraform-validate.png
    ├── 09-terraform-plan.png
    ├── 10-terraform-apply.png
    ├── 11-terraform-output.png
    └── 12-nginx-curl-test.png
```

---

# 🔐 Security and Git Configuration

Terraform state files can contain infrastructure information and should not be committed to GitHub.

The project therefore uses `.gitignore` to exclude:

```text
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
```

The Terraform provider lock file is committed:

```text
.terraform.lock.hcl
```

This helps maintain consistent provider versions.

---

# 🔄 Infrastructure Lifecycle

Terraform manages the infrastructure lifecycle.

### Create

```bash
terraform apply
```

### Inspect

```bash
terraform plan
```

### Get Outputs

```bash
terraform output
```

### Destroy

When the infrastructure is no longer required:

```bash
terraform destroy
```

> ⚠️ `terraform destroy` removes the Terraform-managed GCP resources. Use it only when you are finished with the deployment.

---

# 🎯 Learning Outcomes

Through this project, I practiced:

- Infrastructure as Code
- Terraform configuration
- Terraform providers
- Terraform variables
- Terraform outputs
- Terraform state management
- Terraform planning and deployment
- Google Cloud VPC configuration
- Google Cloud subnet configuration
- Firewall configuration
- Compute Engine provisioning
- Startup scripts
- Docker installation automation
- Nginx container deployment
- Git version control
- GitHub repository management

---

# 📸 Project Screenshots

The main implementation screenshots include:

1. Terraform configuration
2. Terraform initialization
3. Terraform validation
4. Terraform plan
5. Terraform apply
6. GCP VPC
7. GCP subnet
8. GCP firewall
9. Compute Engine VM
10. Docker container
11. Terraform public IP output
12. Nginx web application

---

# ✅ Project Status

**Completed successfully**

Terraform successfully provisioned the Google Cloud infrastructure, configured the Compute Engine VM, installed Docker automatically, deployed Nginx, and exposed the web application through HTTP.

---

# 👨‍💻 Author

**Dheeraj Paramata**

DevOps | Cloud | Infrastructure as Code | Docker | Kubernetes | AWS | GCP | Git/GitHub
