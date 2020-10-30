terraform {
  required_version = "> 0.12.0"

  backend "azurerm" {
  }
}

provider "azurerm" {
  version = ">=2.0.0"
  features {}
}

resource "azurerm_resource_group" "helloworld" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_app_service_plan" "helloworld" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.helloworld.location
  resource_group_name = azurerm_resource_group.helloworld.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "helloworld" {
  name                = var.app_service_name
  location            = azurerm_resource_group.helloworld.location
  resource_group_name = azurerm_resource_group.helloworld.name
  app_service_plan_id = azurerm_app_service_plan.helloworld.id

  site_config {                                                            
     linux_fx_version = "PYTHON|3.8"
   }
}
