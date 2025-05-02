# outputs.tf placeholder
output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}
