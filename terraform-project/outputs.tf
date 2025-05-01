output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}


output "public_instance_ips" {
  description = "Public IP addresses of ASG Instances"
  value = module.autoscaling.public_instance_ips

}


output "alb_dns" {
  value = module.load_balancer.lb_dns
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}