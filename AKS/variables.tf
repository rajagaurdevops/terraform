variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  default     = "East US"
  description = "Azure region"
}

variable "aks_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "aks_dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
}

variable "node_count" {
  type        = number
  default     = 3
  description = "Number of default nodes"
}

variable "vm_size" {
  type        = string
  default     = "Standard_DS2_v2"
  description = "Size of the virtual machines"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.29.2" # Update with a valid version
  description = "AKS Kubernetes version"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "enable_spot" {
  type        = bool
  default     = false
  description = "Enable spot node pool"
}
