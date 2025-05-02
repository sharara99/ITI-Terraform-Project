# variables.tf placeholder
variable "private_subnet_ids" {
  type = list(string)
}
variable "rds_sg_id" {}
variable "db_name" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}
variable "Environment" {}
variable "Owner" {}
