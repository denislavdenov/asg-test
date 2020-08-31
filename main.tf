terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}


resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = "ami-0bcc094591f354be2"
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "bar" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 0
  max_size           = 2
  min_size           = 0

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
  lifecycle { 
    ignore_changes = [desired_capacity] 
  }
}