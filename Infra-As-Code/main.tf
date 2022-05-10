resource "azurerm_resource_group" "k8s" {
    name     = var.resource_group_name
    location = var.location
}

resource "random_id" "log_analytics_workspace_name_suffix" {
    byte_length = 8
}

resource "azurerm_log_analytics_workspace" "monitoring" {
    # The WorkSpace name has to be unique across the whole of azure, not just the current subscription/tenant.
    name                = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
    location            = var.log_analytics_workspace_location
    resource_group_name = azurerm_resource_group.k8s.name
    sku                 = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "monitoring" {
    solution_name         = "ContainerInsights"
    location              = azurerm_log_analytics_workspace.monitoring.location
    resource_group_name   = azurerm_resource_group.k8s.name
    workspace_resource_id = azurerm_log_analytics_workspace.monitoring.id
    workspace_name        = azurerm_log_analytics_workspace.monitoring.name

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}
resource "azurerm_kubernetes_cluster" "k8s" {
		name                = var.cluster_name
                kubernetes_version  = var.kubernetes_version
  		location            = var.location
  		resource_group_name = azurerm_resource_group.k8s.name
  		dns_prefix          = var.cluster_name
	
    default_node_pool {
	      name                = "agentpool"
              node_count          = var.system_node_count
              vm_size             = "Standard_DS2_v2"
              type                = "VirtualMachineScaleSets"
              availability_zones  = [1, 2, 3]
              max_count           = var.max_node_count
              min_count           = var.min_node_count
              enable_auto_scaling = true
    }

   identity {
    	type = "SystemAssigned"
  }

    addon_profile {
        oms_agent {
        enabled                    = true
        log_analytics_workspace_id = azurerm_log_analytics_workspace.monitoring.id
        }
    }

    network_profile {
        load_balancer_sku = "Standard"
        network_plugin = "kubenet"
    }

}

data "azurerm_container_registry" "acr_name" {
  name = var.acr_id
  resource_group_name = var.acr_resourcegroup
}

resource "azurerm_role_assignment" "aks_to_acr_role" {
  scope                = data.azurerm_container_registry.acr_name.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
}
