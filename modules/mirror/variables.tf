variable "topic" {
  type = string
  default = "test-topic"
}

variable "cluster_link" {
  type = string
  default = "bidirectional-link"
}

variable "cluster" {
  type = object({
    id = string
    rest_endpoint = string
    credentials = object({
      key = string
      secret = string
    })
  })
}