 
 
module "clink" {
    source = "./modules/clink"
    providers = {
    confluent = confluent
    }
    for_each = { for link in var.links : link.name => link } 
    environment = var.environment
    link = each.value 
}
