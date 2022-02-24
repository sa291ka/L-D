terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.12"
    }
  }
}

provider "docker" {
  host    = "npipe:////.//pipe//docker_engine"
}

# resource "docker_image" "nodered_image" {
#   name = "nodered/node-red:latest"
# }

resource "random_string" "random" {
  count = local.replicas
  length = 4
  special = false
  upper = false
}

# resource "random_integer" "external_ports" {
#   count = var.replicas
#   min = 2000
#   max = 3000
#   # keepers = {
#   #   name = "$(docker_container.nodered_container.name)"
#   # }
# }

# resource "null_resource" "dockervol1" {
#   provisioner "local-exec" {
#     command = "mkdir noderedvol1"
#   }
# }

resource "docker_container" "nodered_container" {
  count = local.replicas
  name = join("-",["nodered",random_string.random[count.index].result])
  image = "nodered/node-red:latest"
  ports {
    internal = var.int_port
    external = var.ext_port[count.index]
  }
  # volumes {
  #   container_path = "/data"
  #   host_path = "${path.cwd}/noderedvol1"
  # }
  depends_on = [
    # docker_image.nodered_image,
    random_string.random
    # random_integer.external_ports
  ]
}