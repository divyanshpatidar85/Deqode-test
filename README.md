# 🚀 Azure Nomad Cluster Deployment

A Terraform-based solution for deploying a secure, scalable HashiCorp Nomad cluster on Microsoft Azure. This implementation features robust security measures, network isolation, and automated provisioning for production-ready workloads.

![Azure](https://img.shields.io/badge/Azure-Cloud%2520Platform-0078D4?logo=microsoft-azure)
![Terraform](https://img.shields.io/badge/Terraform-Infrastructure%2520as%2520Code-7B42BC?logo=terraform)
![Nomad](https://img.shields.io/badge/Nomad-Orchestration-00CA8E?logo=hashicorp)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📋 Table of Contents

- [Architecture Overview](#architecture-overview)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
- [Accessing the Cluster](#accessing-the-cluster)
- [Sample Application](#sample-application)
- [Maintenance](#maintenance)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

## 🧱 Architecture Overview

### 🔧 Component Diagram

```
Azure Subscription
├── Virtual Network (VNet)
├── Network Security Groups (NSGs)
│   ├── Inbound rules (SSH, HTTP, Nomad ports)
│   └── CIDR-based restrictions
│
├── Nomad Server Nodes (3–5 instances)
│   ├── Consul for service discovery
│   └── Token-based ACL system
│
├── Nomad Client Nodes (1–10 instances)
│   ├── Docker runtime
│   └── Workload execution
│
└── Load Balancer
    ├── Nomad UI access
    └── Application routing
```

### ✅ Design Highlights

- **Azure-First Architecture**: Optimized for Azure's VM and networking capabilities  
- **Scalable Design**: Configurable server and client node counts  
- **Security-First**:  
  - Network isolation through NSGs  
  - Token-based ACLs for API access  
  - SSH key-based authentication  
  - IP allowlisting for critical services  
- **Automated Provisioning**: Complete infrastructure and application deployment via Terraform

---

## 🧰 Prerequisites

Ensure the following tools are installed:

- Azure CLI – [Installation guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- Terraform (≥1.0) – [Download here](https://www.terraform.io/downloads)
- JQ (JSON processor) – [Installation instructions](https://stedolan.github.io/jq/download/)
- Git – [Installation guide](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### SSH Key Setup

Generate an SSH key pair:

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

---

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/divyanshpatidar85/Deqode-test.git
cd Deqode-test
```

### 2. Authenticate with Azure

```bash
az login
```

### 3. Configure Deployment Variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`:

```hcl
subscription_id = "your-azure-subscription-id"
client_id       = "your-azure-client-id"
client_secret   = "your-azure-client-secret"
tenant_id       = "your-azure-tenant-id"
ssh_key_path    = "~/.ssh/id_rsa.pub"
server_count    = 3
client_count    = 5
region          = "EastUS"
```

### 4. Deploy the Infrastructure

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

### 5. Deploy Sample Application

```bash
./scripts/deploy_hello_world.sh
```

---

## 🔧 Configuration

| Variable         | Description                          | Default               |
|------------------|--------------------------------------|------------------------|
| subscription_id  | Azure subscription ID                | -                      |
| client_id        | Azure service principal client ID    | -                      |
| client_secret    | Azure service principal client secret| -                      |
| tenant_id        | Azure tenant ID                      | -                      |
| ssh_key_path     | Path to SSH public key               | ~/.ssh/id_rsa.pub      |
| server_count     | Number of Nomad server nodes         | 3                      |
| client_count     | Number of Nomad client nodes         | 5                      |
| region           | Azure region to deploy to            | EastUS                 |
| vm_size          | Azure VM size for nodes              | Standard_B2s           |
| admin_username   | Admin username for VMs               | nomadadmin             |

### Network Configuration

- Isolated subnets for servers and clients  
- NSG rules restricting access to necessary ports only  
- CIDR block restrictions for administrative access

---

## 🔍 Accessing the Cluster

After deployment, retrieve outputs:

```bash
terraform output nomad_ui_url
terraform output nomad_bootstrap_token
terraform output hello_world_app_url
terraform output ssh_connection_server
```

---

## 📦 Sample Application

The `deploy_hello_world.sh` script demonstrates:

- Service discovery via Consul  
- Load balancing  
- Health checks and monitoring  
- Horizontal scaling

---

## 🛠 Maintenance

### Scaling the Cluster

Update `server_count` or `client_count` in `terraform.tfvars` and run:

```bash
terraform apply -auto-approve
```

### Updating Configuration

Modify Terraform files and apply changes:

```bash
terraform plan
terraform apply
```

### Destroying Resources

```bash
terraform destroy
```

---

## 🐛 Troubleshooting

### Authentication Errors

- Ensure Azure CLI is logged in: `az account show`  
- Verify service principal permissions

### SSH Connection Issues

- Confirm SSH public key path  
- Check NSG rules for IP access

### Nomad Cluster Formation

- Server logs: `journalctl -u nomad`  
- Consul health: `consul members`

### Application Deployment Failures

- Job status: `nomad job status hello-world`  
- Allocation logs: `nomad alloc logs`

### Logs and Diagnostics

```bash
journalctl -u nomad -f
journalctl -u consul -f
nomad node status -self
```

---



