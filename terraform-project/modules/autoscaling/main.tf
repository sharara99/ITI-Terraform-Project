resource "aws_launch_configuration" "app" {
  name                        = "app-launch"
  image_id                    = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  security_groups             = [var.security_group_id]
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
  EOF
}

resource "aws_autoscaling_group" "asg" {
  name                 = "ASG"
  launch_configuration = aws_launch_configuration.app.name
  min_size             = 1
  max_size             = 3
  desired_capacity     = 2
  vpc_zone_identifier  = var.subnets
  target_group_arns    = [var.target_group_arn]

  tag {
    key                 = "Name"
    value               = "ASG_Instance"
    propagate_at_launch = true
  }
}

data "aws_instances" "instances" {
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

resource "null_resource" "generate_asg_inventory" {
  depends_on = [data.aws_instances.instances]

  provisioner "local-exec" {
    command = <<EOT
      export ANSIBLE_HOST_KEY_CHECKING=False
      export ANSIBLE_SSH_ARGS='-o StrictHostKeyChecking=no'
      mkdir -p ${path.module}/../../ansible
      echo "[servers]" > ${path.module}/../../ansible/inventory
%{ for i in range(length(data.aws_instances.instances.public_ips)) ~}
      echo "server${i + 1} ansible_host=${data.aws_instances.instances.public_ips[i]} ansible_user=ec2-user ansible_ssh_private_key_file=./mykey.pem" >> ${path.module}/../../ansible/inventory
%{ endfor ~}
    EOT
  }
}



