environment = "dev" 
share_networks = true

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
 