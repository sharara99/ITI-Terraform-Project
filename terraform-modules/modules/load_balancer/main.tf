# main.tf placeholder
resource "aws_lb" "alb" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]
  subnets = var.public_subnet_ids


  tags = {
    Name = "Public-LB"
  }
}

resource "aws_lb_target_group" "targetgp" {
  name     = "TG-Public"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "HTTP"
    path     = "/"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetgp.arn
  }
}
