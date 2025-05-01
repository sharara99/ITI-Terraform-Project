resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

resource "aws_eip" "nat" {}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.public_subnet_id
}