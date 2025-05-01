variable "Environment" {
  description = "The environment for the resources"
  type        = string
}

variable "Owner" {
  description = "The owner of the resources"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "instance_type" {
  description = "The name for the instance type"
  type        = string
}

variable "ami" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "db_name" {
  description = "The master DB name"
  type        = string
}

variable "db_username" {
  description = "The master DB username"
  type        = string
}

variable "db_password" {
  description = "The master DB password"
  type        = string
  sensitive   = true
}

variable "rds_endpoint" {
  description = "RDS endpoint"
  type = string
  default = ""
}
