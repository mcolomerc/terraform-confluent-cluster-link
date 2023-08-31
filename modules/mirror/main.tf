
resource "confluent_kafka_mirror_topic" "mirror" {

  source_kafka_topic {
    topic_name = var.topic
  }
  cluster_link {
    link_name = var.cluster_link
  }
  # Destination cluster
  kafka_cluster {
    id            = var.cluster.id
    rest_endpoint = var.cluster.rest_endpoint
    credentials {
      key    = var.cluster.account.key
      secret = var.cluster.account.secret
    }
  }
 
}