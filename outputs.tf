 

output "clink_1" {
  value =  values(module.clink).*.clink_1
}

output "clink_2" {
  value =  values(module.clink).*.clink_2
}
 