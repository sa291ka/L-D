variable "int_port" {
  type = number
  sensitive = true
  validation {
    condition = var.int_port >= 4000 && var.int_port < 5000
    error_message = "The internal port number should be in the vaild range(4000 to 4999)."
  }
}
# variable "replicas" {
#   type = number
#   validation {
#     condition = var.replicas < 5
#     error_message = "The number of replical ahould be lees than 5."
#   }
  
# }

variable "ext_port" {
  type = list
  validation {
    condition = max(var.ext_port...) < 6000 && min(var.ext_port...) >= 5000
    error_message = "The external port number should be in the valid range(5000 to 5999)."
  }
}

locals {
  replicas = length(var.ext_port)
}