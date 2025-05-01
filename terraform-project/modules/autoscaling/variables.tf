variable "subnets" {
  type = list(string)
}

variable "security_group_id" {}
variable "key_name" {}
variable "target_group_arn" {}
variable "ami" {}
variable "instance_type" {}