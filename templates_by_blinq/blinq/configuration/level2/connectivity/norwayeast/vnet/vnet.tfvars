vnets = {
  vnet_connectivity_norwayeast = {
    resource_group_key = "rg_vnet_connectivity_norwayeast"
    vnet = {
      name          = "connectivity-norwayeast"
      address_space = ["10.22.0.0/16"]
    }
    #specialsubnets = {
    #  AzureFirewallSubnet = {
    #    name = "AzureFirewallSubnet"
    #    cidr = ["10.22.0.0/24"]
    #  }
    #}
    subnets = {
      AzureBastionSubnet = {
        name = "AzureBastionSubnet" #Must be called AzureBastionSubnet
        cidr = ["10.22.0.0/25"]
        nsg_key = "nsg_azure_bastion"
      }
      jumpbox = {
        name            = "jumpbox"
        cidr            = ["10.22.1.128/25"]
        route_table_key = "internet"
        nsg_key         = "nsg_jumpbox"
      }
      private_endpoints = {
        name                                           = "private_endpoints"
        cidr                                           = ["10.22.2.0/23"]
        enforce_private_link_endpoint_network_policies = true
        route_table_key                                = "internet"
        nsg_key                                        = "nsg_private_endpoints"
      }
    }
  }
}
