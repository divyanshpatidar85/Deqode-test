terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.44.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.7.2"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "5d754141-412c-48f1-ba51-84cd58875835"
  tenant_id       = "cefc5ba8-db83-4da9-8b19-e68934b0289d"
  client_id       = "56468696-0f0e-4370-8d20-1f6d3dadc086"
  client_secret   = "ekd8Q~b-vN3fqe4uNzM9RNtEQpTQefHB09jGvaz3"
   
}

provider "random" {}