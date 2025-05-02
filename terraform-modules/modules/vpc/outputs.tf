output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.subnet_public_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.subnet_public_2.id
}

output "private_subnet_1_id" {
  value = aws_subnet.subnet_private_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.subnet_private_2.id
}
