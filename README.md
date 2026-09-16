# Terraform Infrastructure as Code on Google Cloud

## 📌 Project Overview

This project demonstrates how to provision and manage Google Cloud infrastructure using **Terraform Infrastructure as Code (IaC)**.

Instead of manually creating cloud resources through the Google Cloud Console, Terraform is used to define, deploy, and manage the infrastructure.

The deployed environment includes a custom VPC network, subnet, firewall rule, Compute Engine VM, Docker, and an Nginx web application.

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
                        │
                        ▼
                    Subnet
                        │
                        ▼
              Firewall Rule (HTTP)
                        │
                        ▼
               Compute Engine VM
                        │
                        ▼
                     Docker
                        │
                        ▼
                Nginx Web Server
                        │
                        ▼
                  Web Browser
```

---

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| Google Cloud Platform | Cloud infrastructure |
| Compute Engine | Virtual machine |
| VPC | Network infrastructure |
| Firewall | HTTP traffic control |
| Docker | Container platform |
| Nginx | Web server |
| Debian 12 | VM operating system |
| Git & GitHub | Version control |

---

## ☁️ GCP Infrastructure

### 1. Custom VPC

A custom VPC network was created:

```text
project12-vpc
```

The VPC uses custom subnet configuration instead of automatically created subnets.

### 2. Subnet

A dedicated subnet was created:

```text
Name: project12-subnet
Region: asia-south1
CIDR: 10.10.0.0/24
```

### 3. Firewall Rule

Terraform created an HTTP firewall rule:

```text
Name: project12-vpc-allow-http
Protocol: TCP
Port: 80
Source: 0.0.0.0/0
```

This allows HTTP traffic to reach the Nginx web server.

### 4. Compute Engine VM

Terraform provisions a Compute Engine VM:

```text
Name: project12-app-vm
Zone: asia-south1-b
Machine Type: e2-medium
OS: Debian 12
Disk: 20 GB
```

The VM receives an ephemeral public IP address.

### 5. Docker and Nginx

A Terraform startup script automatically installs Docker and starts an Nginx container.

```bash
apt-get update
apt-get install -y docker.io
systemctl enable docker
systemctl start docker
docker run -d --name project12-nginx -p 80:80 nginx:latest
```

This allows Nginx to start automatically when the VM is created.

---

## 📂 Project Structure

```text
project12-terraform-gcp-infrastructure/
│
├── main.tf
├── variables.tf
├── terraform.tfvars
├── .terraform.lock.hcl
├── README.md
└── .gitignore
```

### `main.tf`

Contains the Terraform configuration for:

- Google Cloud provider
- VPC
- Subnet
- Firewall
- Compute Engine VM
- Docker installation
- Nginx deployment
- Public IP output

### `variables.tf`

Defines reusable Terraform variables such as:

- Project ID
- Region
- Zone
- Machine type
- VM name

### `terraform.tfvars`

Contains the project-specific Terraform variable values.

Sensitive/local configuration files are excluded from Git using `.gitignore`.

---

## 🚀 Terraform Workflow

The infrastructure was deployed using the standard Terraform workflow:

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```

Terraform successfully created the infrastructure.

```text
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

---

## 🔍 Verification

Terraform provides the VM public IP using an output variable:

```bash
terraform output
```

Example:

```text
vm_public_ip = "PUBLIC_IP"
```

The Nginx application can then be tested using:

```bash
curl http://PUBLIC_IP
```

The browser can also be used to access:

```text
http://PUBLIC_IP
```

The deployed application displays the default:

```text
Welcome to nginx!
```

---

## 🔄 Infrastructure Lifecycle

Terraform can manage the complete infrastructure lifecycle.

### Create

```bash
terraform apply
```

### Review Changes

```bash
terraform plan
```

### Destroy

```bash
terraform destroy
```

This demonstrates how Infrastructure as Code can be used to create and remove cloud infrastructure in a repeatable way.

---

## 🔐 Security and Configuration

The project uses:

- A dedicated custom VPC
- A dedicated subnet
- An explicit HTTP firewall rule
- Terraform variables
- `.gitignore` to prevent Terraform state and variable files from being committed

Terraform state files and local variable files are excluded from Git.

---

## 📸 Project Screenshots

### Terraform Configuration

![Terraform Code](screenshots/01-terraform-code.png)

### Terraform Apply

![Terraform Apply](screenshots/02-terraform-apply.png)

### Google Cloud VM

![GCP VM](screenshots/03-gcp-vm.png)

### Nginx Web Application

![Nginx](screenshots/04-nginx.png)

### Terraform Output

![Terraform Output](screenshots/05-terraform-output.png)

---

## 🎯 Learning Outcomes

Through this project, I practiced:

- Infrastructure as Code
- Terraform configuration
- Terraform providers and resources
- Terraform variables
- Terraform outputs
- Google Cloud networking
- VPC and subnet configuration
- GCP firewall configuration
- Compute Engine provisioning
- Startup scripts
- Docker deployment
- Nginx container deployment
- Terraform state management
- Git and GitHub version control

---

## 📌 Project Status

**Completed ✅**

Infrastructure was successfully provisioned on Google Cloud using Terraform, and an Nginx web application was deployed inside a Docker container on the Terraform-created Compute Engine VM.

---

## 👨‍💻 Author

**Dheeraj Paramata**

GitHub: [Dheerajparamata](https://github.com/Dheerajparamata)
