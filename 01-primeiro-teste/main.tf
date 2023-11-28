terraform {
  # required_version = "= 1.3.0"
  # required_version = "!= 1.3.0"
  # required_version = ">= 1.3.0, < 1.3.0"
  required_version = "~> 1.0.0" #1.0.0 até 1.0.x
  required_providers {
    aws = {
      version = "value"
      source = "value"
    }

    azurerm = {
      version = "value"
      source = "value"
    }
  }

  backend "azurerm" {
    
  }
}