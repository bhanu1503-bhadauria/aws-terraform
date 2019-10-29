resource "aws_lb" "bhanuALB" {
  name               = "bhanuALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.aws_subnet_public

  tags = {
    Name = "bhanuALB"
  }
}

resource "aws_lb_target_group" "bhanuTG" {
  name     = "bhanuTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc-id
  deregistration_delay = 300
  tags = {
    Name = "bbTG"
  }
}

