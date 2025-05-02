# variables.tf placeholder
variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "alb_target_group_arn" {}
variable "rds_endpoint" {}
variable "public_sg" {}
variable "Environment" {}
variable "Owner" {}
