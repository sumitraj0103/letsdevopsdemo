variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
variable "max_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}
variable "min_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
}

variable "acr_id" {}
variable "acr_resourcegroup" {}
variable "dns_prefix" {
    type        = string
    description = "Name of the Log Analytic"
}

variable log_analytics_workspace_name {
    type        = string
    description = "Name of the Log Analytic"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    type        = string
    description = "location of the Log Analytic"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    type        = string
    description = "Workspace SKU"
}
