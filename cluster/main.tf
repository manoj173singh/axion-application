resource "azurerm_resource_group" "suraj_rg" {
  name     = "k8s_app"
  location = "East US"
}

# AKS Cluster
resource "azurerm_kubernetes_cluster" "suraj_aks" {
  name                = "suraj_k8"
  location            = azurerm_resource_group.suraj_rg.location
  resource_group_name = azurerm_resource_group.suraj_rg.name
  dns_prefix          = "surajaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s" # 💰 cheapest practical option
  }

  identity {
    type = "SystemAssigned"
  }

  # 🔥 Network (no public LB usage + Calico)
  network_profile {
    network_plugin    = "azure"
    network_policy    = "calico"
    # load_balancer_sku = "standard"
  }

  # ❌ No monitoring enabled (default me disabled hi hota hai)

  tags = {
    environment = "dev"
  }
}