resource "aws_ecs_cluster" "main" {
  name = "devops-build-lab"
}

resource "aws_ecs_task_definition" "app" {

  family                   = "log-analyzer"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution.arn

  container_definitions = jsonencode([
    {
      name  = "log-analyzer"
      image = "${var.ecr_repo_url}:latest"

      portMappings = [
        {
          containerPort = 8000
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group = "/ecs/log-analyzer"
          awslogs-region = "us-east-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "app" {

  name            = "log-analyzer-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.public_a.id,
      aws_subnet.public_b.id
    ]
    assign_public_ip = true
  }

  load_balancer {

    target_group_arn = aws_lb_target_group.ecs_tg.arn
    container_name   = "log-analyzer"
    container_port   = 8000
  }
}