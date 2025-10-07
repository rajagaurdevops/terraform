# -----------------------------------------
# Resource Group
# -----------------------------------------
resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
}

# -----------------------------------------
# Log Analytics Workspace
# -----------------------------------------
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "${var.aks_name}-law"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  sku                 = "Free"               # Free tier
  retention_in_days   = 30
}

# -----------------------------------------
# Azure Container Registry (ACR)
# -----------------------------------------
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Standard"
  admin_enabled       = false
}

# -----------------------------------------
# AKS Cluster using default network
# -----------------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = var.aks_dns_prefix
  kubernetes_version  = var.kubernetes_version

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  default_node_pool {
    name                = "default"
    node_count          = var.node_count
    vm_size             = var.vm_size
    os_disk_size_gb     = 30
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5
    type                = "VirtualMachineScaleSets"
    # No need to specify vnet_subnet_id, will use default network
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  api_server_access_profile {
    enable_private_cluster = false
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
    }
    azure_policy {
      enabled = true
    }
  }

  tags = {
    environment = "production"
    owner       = "devops-team"
  }
}

# -----------------------------------------
# Grant AKS Access to ACR
# -----------------------------------------
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
