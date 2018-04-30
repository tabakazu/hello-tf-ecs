# ECS Cluster
resource "aws_ecs_cluster" "taba" {
  name = "taba-cluster"
}


# ECS TaskDefinition
resource "aws_ecs_task_definition" "01" {
  family                = "taba-task-definition"
  container_definitions = <<-JSON
  [
    {
      "name": "taba",
      "image": "${var.repository_url}",
      "memory": 128,
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 0
        }
      ]
    }
  ]
  JSON
}


# ECS Service
resource "aws_ecs_service" "01" {
  name            = "taba-service"
  cluster         = "${aws_ecs_cluster.taba.id}"
  task_definition = "${aws_ecs_task_definition.01.arn}"
  desired_count   = 2
  iam_role        = "${aws_iam_role.ecs-service.arn}"


  load_balancer {
    target_group_arn = "${aws_lb_target_group.web.arn}"
    container_name = "taba"
    container_port = 80
  }
}
