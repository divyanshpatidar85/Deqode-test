variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "nomad-rg"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "vm_size" {
  description = "Virtual machine size"
  type        = string
  default     = "Standard_B2ms"
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "azureuser"
}

variable "ssh_source_cidr" {
  description = "CIDR block for SSH access"
  type        = string
  default     = "0.0.0.0/0"
}

variable "nomad_ui_source_cidr" {
  description = "CIDR block for Nomad UI access (restrict this for security)"
  type        = string
  default     = "0.0.0.0/0"  # Change this to your IP range for security
}

variable "server_count" {
  description = "Number of Nomad server nodes"
  type        = number
  default     = 1
  validation {
    condition     = var.server_count >= 1 && var.server_count <= 5
    error_message = "Server count must be between 1 and 5."
  }
}

variable "client_count" {
  description = "Number of Nomad client nodes"
  type        = number
  default     = 2
  validation {
    condition     = var.client_count >= 1 && var.client_count <= 10
    error_message = "Client count must be between 1 and 10."
  }
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  description = "Subnet address prefixes"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "environment" {
  description = "Environment tag"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project tag"
  type        = string
  default     = "nomad"
}