resource "aws_ecs_cluster" "bhanu_cluster" {
  name = "bhanu_cluster"
}

resource "aws_ecs_task_definition" "bhanuNginx" {
  family                = "bhanuNginx"
  cpu                   = 256
  memory                = 256
  network_mode          = "bridge"
  requires_compatibilities = ["EC2"]
  container_definitions = data.template_file.container-definition.rendered
}

data "template_file" "container-definition" {
  template = file("${path.module}/task-definition.json")
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = var.ecs-lb-arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.ecs-target-group-arn
  }
}

resource "aws_ecs_service" "Service" {
  name = "bhanuService"
  cluster = aws_ecs_cluster.bhanu_cluster.id
  task_definition = aws_ecs_task_definition.bhanuNginx.arn

  desired_count = 1

  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  # iam_role = aws_iam_role.bhanu-ecs-service-role.name

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }
  	load_balancer {
    	target_group_arn  = var.ecs-target-group-arn
    	container_port    = 80
    	container_name    = "nginx"
	}

  depends_on = ["aws_lb_listener.front_end"]

}

resource "aws_iam_role" "bhanu-ecs-instance-role" {
  name = "bhanu-ecs-instance-role"
  assume_role_policy = data.aws_iam_policy_document.bhanu-ecs-instance-policy.json
}

data "aws_iam_policy_document" "bhanu-ecs-instance-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "bhanu-ecs-instance-role-attachment" {
    role = aws_iam_role.bhanu-ecs-instance-role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "bhanu-ecs-instance-profile" {
    name = "bhanu-ecs-instance-profile"
    role = aws_iam_role.bhanu-ecs-instance-role.name
    
}

