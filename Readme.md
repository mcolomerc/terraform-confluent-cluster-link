# Cluster Linking management 

Bidirectional cluster linking 

```hcl
links = [
  {
    name = "bid-link"  
    cluster_1 = {
      id = "lkc-xxxxx"
      credentials = {
        key    = "value"
        secret = "value"
      }
      mirrors = ["topic-3-2"]
    },
    cluster_2= {
      id = "lkc-xxxxx"
      credentials = {
        key    = "value"
        secret = "value"
      }
      mirrors = ["topic-6"]
    } 
  }
]
```

### Netowork Share 

Cluster on different Confluent Cloud Networks can be linked using the `share_networks` flag.

```hcl
share_networks = true
````
 