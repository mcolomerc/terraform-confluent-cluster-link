environment = "dev" 
 
links = [
  {
    name = "bid-link"  
    cluster_1 = {
      id = "lkc-xxxxx"
      rest_endpoint = ":443" 
      bootstrap_endpoint = ":9092"
      credentials = {
        key    = "value"
        secret = "value"
      }
      mirrors = ["topic-3-2"]
    },
    cluster_2= {
      id = "lkc-xxxxx"
      rest_endpoint = ":443" 
      bootstrap_endpoint = ":9092"
      credentials = {
        key    = "value"
        secret = "value"
      }
      mirrors = ["topic-6"]
    } 
  }
]
 
 