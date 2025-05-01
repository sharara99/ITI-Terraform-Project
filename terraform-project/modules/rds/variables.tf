variable "private_subnets" {
  type = list(string)
}

variable "security_group_id" {}

variable "username" {}
variable "password" {
  sensitive = true
}