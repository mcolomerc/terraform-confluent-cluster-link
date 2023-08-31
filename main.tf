locals {
    clinkMap = { for link in var.links : link.name => link }
    clusterList_1 = var.links[*].cluster_1.id
    clusterList_2 = var.links[*].cluster_2.id
    clusterList = concat(local.clusterList_1, local.clusterList_2)
}
// For each link in the list, get the cluster resource
data "confluent_kafka_cluster" "clusters" {
  for_each = toset(local.clusterList) 
  id = each.value
  environment {
    id = var.environment
  }
}

locals {
  networks = [ for network in data.confluent_kafka_cluster.clusters : network.network_id ]
}

// For each cluster in the list get the network id and create a network share
module "network_share" {
  count = var.share_networks ? 1 : 0
  source   = "github.com/mcolomerc/terraform-confluent-network-share" 
  environment = var.confluent.environment.id
  providers = {
    confluent.confluent_cloud = confluent.confluent_cloud 
  }
  confluent_cloud_network_ids = local.networks 
}
 
// For each cluster in the map 
module "clink" {
    source = "../clink"
    for_each = local.clinkMap
    environment = var.environment
    link = each.value 
}
