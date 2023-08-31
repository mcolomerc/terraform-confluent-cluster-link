data "confluent_kafka_cluster" "cluster_1" {
  id = var.link.cluster_1.id
  environment {
    id = var.environment
  }
}

data "confluent_kafka_cluster" "cluster_2" {
  id = var.link.cluster_2.id
  environment {
    id = var.environment
  }
}


// https://docs.confluent.io/cloud/current/multi-cloud/cluster-linking/cluster-links-cc.html#create-a-cluster-link-in-bidirectional-mode
resource "confluent_cluster_link" "bidirectional-link-1" {
  link_name = var.link.name
  link_mode = "BIDIRECTIONAL"
  local_kafka_cluster {
    id            = data.confluent_kafka_cluster.cluster_1.id
    rest_endpoint = data.confluent_kafka_cluster.cluster_1.rest_endpoint
    credentials {
      key    = var.link.cluster_1.credentials.key
      secret = var.link.cluster_1.credentials.secret
    }
  }

  remote_kafka_cluster {
    id                 = data.confluent_kafka_cluster.cluster_2.id
    bootstrap_endpoint = data.confluent_kafka_cluster.cluster_2.bootstrap_endpoint
    credentials {
      key    = var.link.cluster_2.credentials.key
      secret = var.link.cluster_2.credentials.secret
    }
  }
}

resource "confluent_cluster_link" "bidirectional-link-2" {
  link_name = var.link.name
  link_mode = "BIDIRECTIONAL"
  local_kafka_cluster {
    id            = data.confluent_kafka_cluster.cluster_2.id
    rest_endpoint = data.confluent_kafka_cluster.cluster_2.rest_endpoint
    credentials {
      key    = var.link.cluster_2.credentials.key
      secret = var.link.cluster_2.credentials.secret
    }
  }

  remote_kafka_cluster {
    id                 = data.confluent_kafka_cluster.cluster_1.id
    bootstrap_endpoint = data.confluent_kafka_cluster.cluster_1.bootstrap_endpoint
    credentials {
      key    = var.link.cluster_1.credentials.key
      secret = var.link.cluster_1.credentials.secret
    }
  }
}

module "cluster_1_mirrors" {
  source       = "../mirror"
  for_each     = toset(var.link.cluster_1.mirrors)
  topic        = each.value
  cluster_link = confluent_cluster_link.bidirectional-link.link_name
  cluster = {
    id            = data.confluent_kafka_cluster.cluster_1.id
    rest_endpoint = data.confluent_kafka_cluster.cluster_1.rest_endpoint
    credentials = {
      key    = var.link.cluster_1.credentials.key
      secret = var.link.cluster_1.credentials.secret
    }
  }
}
module "cluster_2_mirrors" {
  source       = "../mirror"
  for_each     = toset(var.link.cluster_2.mirrors)
  topic        = each.value
  cluster_link = confluent_cluster_link.bidirectional-link.link_name
  cluster = {
    id            = data.confluent_kafka_cluster.cluster_2.id
    rest_endpoint = data.confluent_kafka_cluster.cluster_2.rest_endpoint
    credentials = {
      key    = var.link.cluster_2.credentials.key
      secret = var.link.cluster_2.credentials.secret
    }
  }
}
