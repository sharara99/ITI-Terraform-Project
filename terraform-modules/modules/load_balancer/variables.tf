# variables.tf placeholder
variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "alb_sg" {}
variable "Environment" {}
variable "Owner" {}
