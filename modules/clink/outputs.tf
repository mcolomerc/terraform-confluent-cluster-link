output "clink_1" {
    value = confluent_cluster_link.bidirectional-link-1
}

output "clink_2" {
    value = confluent_cluster_link.bidirectional-link-2
}

output "mirrors" {
    value = concat(module.cluster_1_mirrors, module.cluster_2_mirrors)
}