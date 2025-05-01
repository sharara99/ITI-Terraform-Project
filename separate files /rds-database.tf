resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet_private_1.id, aws_subnet.subnet_private_2.id]

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_instance" "rds_master" {
  identifier              = "rds-master-instance"
  engine                  = "mysql"
  engine_version          = "8.0.35" # Specify a supported MySQL version
  instance_class          = "db.t3.micro" # Use a supported instance class
  allocated_storage       = 20          
  storage_type            = "gp2"
  username                = var.db_username
  password                = var.db_password
  db_name                 = "mydatabase"
  port                    = 3306
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  publicly_accessible     = false
  multi_az                = false        
  backup_retention_period = 7
  skip_final_snapshot     = true

  tags = {
    Name        = "RDS Master"
    Environment = var.Environment
    Owner       = var.Owner
  }
}