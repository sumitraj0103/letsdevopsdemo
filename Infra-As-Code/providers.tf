provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name      = "devops-common-resources"
    storage_account_name     = "terraformstspringboot"
    container_name           = "terraformstate"
    key                      = "terraform.tfstate"
  }
}