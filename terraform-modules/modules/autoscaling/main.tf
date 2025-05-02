# main.tf placeholder
resource "aws_launch_configuration" "app" {
  name_prefix                 = "app-"
  image_id                    = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = [var.public_sg]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd php git php-mysqlnd unzip awscli -y
    git clone https://github.com/sharara99/My-To-Do-List.git /var/www/html
    systemctl start httpd
    systemctl enable httpd
    sed -i 's/REPLACE_ME/${var.rds_endpoint}/' /var/www/html/db.php
  EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "ASG"
  launch_configuration = aws_launch_configuration.app.name
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = var.public_subnet_ids
  target_group_arns    = [var.alb_target_group_arn]

  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}

data "aws_instances" "asg_instances" {
  depends_on = [aws_autoscaling_group.asg]

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  filter {
    name   = "tag:Name"
    values = ["ASG_Instance"]
  }
}
