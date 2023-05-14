# Terraform Infrastructure for ECS on EC2 with Auto Scaling and ECR

This project sets up an AWS ECS cluster running on EC2 Spot Fleet instances with Auto Scaling enabled.

## Prerequisites

- Terraform installed
- AWS account with necessary permissions
- AWS CLI configured with your AWS account

## Structure

- main.tf - main file where all modules are called from.
- modules/ - directory containing all the modules:
  - ecr/ - ECR repository configuration
  - vpc/ - VPC configuration
  - subnets/ - Subnet configuration
  - route_table/ - Route table configuration
  - security_group/ - Security group configuration
  - ec2/ - EC2 configuration
  - ecs-cluster/ - ECS cluster configuration
  - ecs-service/ - ECS service configuration