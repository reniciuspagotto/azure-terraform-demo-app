terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

// data "azurerm_resource_group" "main" {
//     name     = "TerraformMgInfoDemo"
// }

// resource "azurerm_service_plan" "main" {
//     name                = "terraform-demo-serviceplan"
//     resource_group_name = "${data.azurerm_resource_group.main.name}"
//     location            = "${data.azurerm_resource_group.main.location}"
//     os_type             = "Windows"
//     sku_name            = "B1"
// }

// resource "azurerm_windows_web_app" "main" {
//     name                = "terraform-demo-appservice"
//     resource_group_name = "${data.azurerm_resource_group.main.name}"
//     location            = "${data.azurerm_resource_group.main.location}"
//     service_plan_id     = azurerm_service_plan.main.id

//     site_config {}
// }

resource "azurerm_resource_group" "main" {
    name     = "TerraformDemoApp"
    location = "Brazil South"
}

resource "azurerm_service_plan" "main" {
    name                = "terraform-demo-serviceplan"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_resource_group.main.location
    os_type             = "Windows"
    sku_name            = "B1"
}

resource "azurerm_windows_web_app" "main" {
    name                = "terraform-demo-appservice"
    resource_group_name = azurerm_resource_group.main.name
    location            = azurerm_service_plan.main.location
    service_plan_id     = azurerm_service_plan.main.id
    app_settings = {
      "WEBSITE_RUN_FROM_PACKAGE"        = "1"
      "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true"
    }

    site_config {}
}