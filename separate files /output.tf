output "vpc_id" {
  description = "The ID of the created VPC"
  value       = [aws_vpc.main_vpc.id, aws_vpc.main_vpc.cidr_block]
}

output "public_subnet_cidrs" {
  description = "The IDs of the public subnets"
  value       = [aws_subnet.subnet_public_1.cidr_block, aws_subnet.subnet_public_2.cidr_block]
}

output "private_subnet_cidrs" {
  description = "The IDs of the public subnets"
  value       = [aws_subnet.subnet_private_1.cidr_block, aws_subnet.subnet_private_2.cidr_block]
}

output "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.test.dns_name
}

# Output the public IPs of the instances in the Auto Scaling Group
output "public_instance_ips" {
  description = "Public IP addresses of instances in the Auto Scaling Group"
  value       = data.aws_instances.asg_instances.public_ips
}

# Create the inventory file
# resource "null_resource" "generate_asg_inventory" {
#   depends_on = [data.aws_instances.asg_instances]

#   provisioner "local-exec" {
#     command = <<EOF
#       export ANSIBLE_HOST_KEY_CHECKING=False
#       export ANSIBLE_SSH_ARGS='-o StrictHostKeyChecking=no'
#       echo "[servers]" > ./inventory
# %{ for i in range(length(data.aws_instances.instances.public_ips)) ~}
#       echo "server${i + 1} ansible_host=${data.aws_instances.instances.public_ips[i]} ansible_user=ec2-user ansible_ssh_private_key_file=./mykey.pem" >> ./inventory
# %{ endfor ~}
#     EOF
#   }
# }


output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.rds_master.endpoint
}


