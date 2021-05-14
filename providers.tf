provider azurerm {
  subscription_id = local.settings.subscription_id
  features {}
}

provider azuread {
  tenant_id = "d2846bb0-0b6e-4c52-a8cb-45f42233fd29"
}

provider "azuredevops" {
  org_service_url = "https://dev.azure.com/baugruppe"
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.46.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "~> 0.1.3"
    }
  }
}

