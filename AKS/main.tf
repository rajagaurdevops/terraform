# -----------------------------------------
# Resource Group
# -----------------------------------------
resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name  # Resource group name from variable
  location = var.location             # Azure region/location from variable
}

# -----------------------------------------
# Virtual Network & Subnet
# -----------------------------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "aks-vnet"                  # Name of the virtual network
  address_space       = ["10.0.0.0/16"]            # IP range for the VNet
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"              # Name of the subnet
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]           # Subnet IP range within VNet
}

# -----------------------------------------
# Log Analytics Workspace
# -----------------------------------------
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "${var.aks_name}-law"      # Name of the workspace
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  sku                 = "PerGB2018"               # Pricing tier
  retention_in_days   = 30                         # Log retention period
}

# -----------------------------------------
# Azure Container Registry (ACR)
# -----------------------------------------
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name               # Name of ACR from variable
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Standard"                # Standard SKU for ACR
  admin_enabled       = false                      # Admin user disabled for security
}

# -----------------------------------------
# AKS Cluster
# -----------------------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = var.aks_dns_prefix         # DNS prefix for AKS
  kubernetes_version  = var.kubernetes_version     # Kubernetes version

  identity {
    type = "SystemAssigned"                        # Managed identity for AKS
  }

  role_based_access_control {
    enabled = true                                 # Enable RBAC for cluster
  }

  default_node_pool {
    name                = "default"
    node_count          = var.node_count           # Number of nodes
    vm_size             = var.vm_size             # VM size for nodes
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id  # Subnet where nodes are deployed
    os_disk_size_gb     = 30                        # OS disk size for each node
    enable_auto_scaling = true                      # Enable cluster autoscaling
    min_count           = 1                         # Minimum number of nodes
    max_count           = 5                         # Maximum number of nodes
    type                = "VirtualMachineScaleSets" # Use VMSS for scaling
  }

  network_profile {
    network_plugin    = "azure"                     # Azure CNI network plugin
    network_policy    = "azure"                     # Azure network policy
    load_balancer_sku = "standard"                  # Standard load balancer
    outbound_type     = "loadBalancer"             # Outbound traffic type
  }

  api_server_access_profile {
    enable_private_cluster = false                  # Cluster API is publicly accessible
  }

  addon_profile {
    oms_agent {
      enabled                    = true            # Enable monitoring agent
      log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
    }
    azure_policy {
      enabled = true                             # Enable Azure Policy for cluster
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
  role_definition_name = "AcrPull"                       # Role allowing AKS to pull images
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
































# ----------------------
# Resource Group
# ----------------------
resource "azurerm_resource_group" "aks_rg" {
  name     = var.resource_group_name
  location = var.location
}

# ----------------------
# Virtual Network & Subnet
# ----------------------
resource "azurerm_virtual_network" "vnet" {
  name                = "aks-vnet"
  address_space       = ["10.0.0.0/8"]
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.aks_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.240.0.0/16"]
}

# ----------------------
# Log Analytics Workspace for Monitoring
# ----------------------
resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "${var.aks_name}-law"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# ----------------------
# Azure Container Registry (ACR)
# ----------------------
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  sku                 = "Standard"
  admin_enabled       = false
}

# ----------------------
# AKS Cluster with RBAC, Managed Identity, Monitoring
# ----------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = var.aks_dns_prefix

  kubernetes_version  = var.kubernetes_version
  role_based_access_control_enabled = true

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                = "default"
    node_count          = var.node_count
    vm_size             = var.vm_size
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    type                = "VirtualMachineScaleSets"
    os_disk_size_gb     = 30
    enable_auto_scaling = true
    min_count           = 1
    max_count           = 5
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id
    }
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  tags = {
    environment = "playground"
  }
}

# ----------------------
# Grant AKS Access to ACR
# ----------------------
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
