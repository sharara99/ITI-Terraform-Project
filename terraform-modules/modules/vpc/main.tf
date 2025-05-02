# main.tf placeholder
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name        = "main_vpc"
    Environment = var.Environment
    Owner       = var.Owner
  }
}

resource "aws_subnet" "subnet_public_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 0)
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-public-1"
    Environment = var.Environment
    Owner       = var.Owner
  }
}

resource "aws_subnet" "subnet_private_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 2)
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name        = "subnet-private-1"
    Environment = var.Environment
    Owner       = var.Owner
  }
}

resource "aws_subnet" "subnet_public_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 1)
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-public-2"
    Environment = var.Environment
    Owner       = var.Owner
  }
}

resource "aws_subnet" "subnet_private_2" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 3)
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name        = "subnet-private-2"
    Environment = var.Environment
    Owner       = var.Owner
  }
}
