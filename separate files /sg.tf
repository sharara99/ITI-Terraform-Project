# Create Security Group for Public Subnets
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main_vpc.id

  # Allow HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "public_sg"
    Environment = var.Environment
    Owner       = var.Owner
  }
}

# Security Group for Primary RDS Database
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main_vpc.id

  # Allow MySQL/Aurora traffic (port 3306) from application servers
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [cidrsubnet(var.vpc_cidr, 4, 0), cidrsubnet(var.vpc_cidr, 4, 1)] # Replace with your application server subnet CIDR
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "rds_primary_sg"
    Environment = var.Environment
    Owner       = var.Owner
  }
}
