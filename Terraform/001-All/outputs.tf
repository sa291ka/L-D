
output "container_name" {
  description = "container name"
  value = [for i in docker_container.nodered_container[*]: join(":",["(with random generator)",i.name])]
}

output "container_access_link" {
  description = "access container"
  value = [for i in docker_container.nodered_container[*]: format("%#v --> http://%#v:%#v",i.name,i.ip_address,i.ports[0].external)]
}