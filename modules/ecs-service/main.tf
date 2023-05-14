variable "service_name" {
  description = "ECS Service"
  type        = string
}

variable "task_family" {
  description = "Task Family"
  type        = string
}

variable "container_name" {
  description = "ECS container"
  type        = string
}

variable "image" {
  description = "The Docker image to use for the task definition"
  type        = string
}

variable "cluster_id" {
  description = "ECS cluster ID"
  type        = string
}

resource "aws_ecs_task_definition" "task" {
  family                = var.task_family
  container_definitions = <<DEFINITION
  [
    {
      "name": "${var.container_name}",
      "image": "${var.image}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
}

resource "aws_ecs_service" "service" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.task.arn
  desired_count   = 2

  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
}

output "service_id" {
  description = "ID of the ECS Service"
  value       = aws_ecs_service.service.id
}

