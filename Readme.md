# Cluster Linking management

Bidirectional cluster linking

```hcl
links = [
  {
    name = "bid-link"  
    cluster_1 = {
      id = "lkc-mkqvww"
      bootstrap_endpoint = "lkc-mkqvww.dom4g2l2ypr.eu-central-1.aws.confluent.cloud:9092"
      rest_endpoint = "https://lkc-mkqvww.dom4g2l2ypr.eu-central-1.aws.confluent.cloud:443"
      service_account = "mcolomer-admin" 
      mirrors = ["topic-2-1"]
    },
    cluster_2= {
      id = "lkc-5m2732"
      bootstrap_endpoint = "lkc-5m2732.dommp7518ew.eu-west-1.aws.confluent.cloud:9092"
      rest_endpoint = "https://lkc-5m2732.dommp7518ew.eu-west-1.aws.confluent.cloud:443"
      service_account = "mcolomer-admin" 
      mirrors = ["topic-1-1"]
    } 
  }
]
```

## Validation

Confluent CLI commands:

```bash 
 confluent kafka cluster list
  Current |     ID     |               Name               |   Type    | Provider |    Region    | Availability | Status  
----------+------------+----------------------------------+-----------+----------+--------------+--------------+---------
          | lkc-5m2732 | mcolomer-standard-inventory_dev2 | DEDICATED | aws      | eu-west-1    | multi-zone   | UP      
  *       | lkc-mkqvww | mcolomer-standard-inventory_dev1 | DEDICATED | aws      | eu-central-1 | multi-zone   | UP     
```
  
```bash
confluent kafka link list
    Name   | Source Cluster | Destination Cluster | State  | Error | Error Message  
-----------+----------------+---------------------+--------+-------+----------------
  bid-link |                |                     | ACTIVE |       |                

```

```bash
 confluent kafka mirror list --link bid-link
  Link Name | Mirror Topic Name | Source Topic Name | Mirror Status | Status Time (ms) | Num Partition | Max Per Partition Mirror Lag  
------------+-------------------+-------------------+---------------+------------------+---------------+-------------------------------
  bid-link  | topic-2-1         | topic-2-1         | ACTIVE        |    1693846658778 |             3 |                            0 
``` 
 
```bash 
confluent kafka cluster use lkc-5m2732
Set Kafka cluster "lkc-5m2732" as the active cluster for environment "env-zmz2zd".
```

```bash
confluent kafka mirror list --link bid-link
  Link Name | Mirror Topic Name | Source Topic Name | Mirror Status | Status Time (ms) | Num Partition | Max Per Partition Mirror Lag  
------------+-------------------+-------------------+---------------+------------------+---------------+-------------------------------
  bid-link  | topic-1-1         | topic-1-1         | ACTIVE        |    1693846658911 |             3 |                            0  
```