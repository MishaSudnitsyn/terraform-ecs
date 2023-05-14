variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

resource "aws_launch_configuration" "lc" {
  image_id        = "ami-03aefa83246f44ef2"  # Amazon Linux 2023 AMI 2023.0.20230503.0 x86_64 HVM kernel-6.1
  instance_type   = var.instance_type

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1

  vpc_zone_identifier = var.subnet_ids

  launch_configuration = aws_launch_configuration.lc.id

  lifecycle {
    create_before_destroy = true
  }
}