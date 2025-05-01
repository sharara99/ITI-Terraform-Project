resource "aws_eip" "lb" {

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.subnet_public_1.id

  tags = {
    Name = "Main NAT"
  }

}
