terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

  /*backend "azurerm" {
    resource_group_name  = "rg-tf-state"
    storage_account_name = "alparslanterraformstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
    use_oidc             = true
    use_azuread_auth     = true
  }*/