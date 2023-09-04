# Confluent Environment
variable "environment" {
  type = string
  default = "dev"
}

# Confluent Cloud Kafka clusters to link
variable "link" {
  type = object({
    name     = string
    cluster_1 = object({
      id            = string
      rest_endpoint = string 
      bootstrap_endpoint = string
      credentials = object({
        key    = string
        secret = string
      })
      mirrors = list(string)
    })
    cluster_2 = object({
      id            = string
      rest_endpoint = string 
      bootstrap_endpoint = string
      credentials = object({
        key    = string
        secret = string
      })
      mirrors = list(string)
    })
    })
}

 
 