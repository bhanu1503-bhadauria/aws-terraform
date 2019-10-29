resource "aws_launch_template" "bhanuLT" {
  name                    = "bhanuLT"
  image_id                = "ami-0f846c06eb372f19a"
  instance_type           = "t2.micro"
  key_name                = "bhanu1"
  vpc_security_group_ids  = [var.security_group_id]

  iam_instance_profile {
    name    = var.ecs-instance-profile-name
  } 
  #iam_instance_profile    = var.ecs-instance-profile-name
  user_data               = filebase64("${path.module}/userdata.sh")
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "bhanu"
    }
  }
}

resource "aws_autoscaling_group" "bhanuASG" {
  name                 = "bhanuASG"
  desired_capacity     = 1
  max_size             = 4
  min_size             = 1
  vpc_zone_identifier  = var.aws_subnet_public
  target_group_arns    = [var.tg_arn]
  termination_policies = ["OldestInstance"]

  launch_template {
    id      = aws_launch_template.bhanuLT.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attach" {
  autoscaling_group_name = aws_autoscaling_group.bhanuASG.name
  alb_target_group_arn   = var.tg_arn
}

# resource "template_file" "ecs-launch-configuration-user-data" {
#     template = file("${path.module}/userdata.sh")
# }