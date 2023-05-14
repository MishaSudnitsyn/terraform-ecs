variable "cluster_name" {
  description = "ECS Cluster"
  type        = string
}

resource "aws_ecs_cluster" "cluster" {
  name = var.cluster_name
}

output "cluster_id" {
  description = "ID of the ECS Cluster"
  value       = aws_ecs_cluster.cluster.id
}
