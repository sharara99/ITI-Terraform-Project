variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "Environment" {
  description = "Environment name"
  type        = string
}

variable "Owner" {
  description = "Owner of the infrastructure"
  type        = string
}

variable "ami" {
  description = "AMI ID for EC2 Instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}
variable "key_name" {
  description = "SSH key pair name"
  type        = string
}
