# Create Load Balancer (ALB)
resource "aws_lb" "test" {
  name                       = "ALB"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.public_sg.id]
  subnets                    = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]
  enable_deletion_protection = false

  tags = {
    Name = "Public-LB"
  }

}

# Create Target Group
resource "aws_lb_target_group" "targetgp" {
  name     = "TG-Public"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    protocol = "HTTP"
    path     = "/"
  }

  tags = {
    Name = "TG-Public"
  }
}

# Create Listener for ALB
resource "aws_lb_listener" "test" {
  load_balancer_arn = aws_lb.test.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetgp.arn
  }
}
