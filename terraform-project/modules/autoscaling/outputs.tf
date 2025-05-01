output "public_instance_ips" {
  description = "Public IP addresses of instances in the Auto Scaling Group"
  value       = data.aws_instances.instances.public_ips
}
