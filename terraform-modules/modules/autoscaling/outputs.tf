# outputs.tf placeholder
output "instance_public_ips" {
  value = data.aws_instances.asg_instances.public_ips
}
