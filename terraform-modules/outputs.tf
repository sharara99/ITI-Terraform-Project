# outputs.tf placeholder
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "alb_dns" {
  value = module.load_balancer.alb_dns
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
