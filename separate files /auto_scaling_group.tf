# Launch Template
resource "aws_launch_template" "app" {
  name_prefix   = "app-"
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.UbuntuKP.key_name

  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true

  user_data = base64encode(<<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd php git php-mysqlnd unzip awscli

    git clone https://github.com/sharara99/My-To-Do-List.git /var/www/html

    systemctl start httpd
    systemctl enable httpd

    sed -i 's/REPLACE_ME/${rds_endpoint}/' /var/www/html/db.php
  EOF
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group using Launch Template
resource "aws_autoscaling_group" "app" {
  name                = "ASG"
  min_size            = 1
  max_size            = 3
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.subnet_public_1.id, aws_subnet.subnet_public_2.id]
  target_group_arns   = [aws_lb_target_group.targetgp.arn]

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}

# Fetch running instances with ASG tag
data "aws_instances" "asg_instances" {
  depends_on = [aws_autoscaling_group.app]

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  filter {
    name   = "tag:Name"
    values = ["ASG_Instance"]
  }
}
