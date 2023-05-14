variable "repository_name" {
  description = "ECR repository"
  type        = string
}

resource "aws_ecr_repository" "repository" {
  name = var.repository_name
}

output "repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.repository.repository_url
}
