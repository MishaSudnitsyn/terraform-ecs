provider "aws" {
  region = "eu-central-1"
}

module "ecs_cluster" {
  source       = "./modules/ecs-cluster"
  cluster_name = "my-cluster"
}

module "ecs_service" {
  source          = "./modules/ecs-service"
  service_name    = "my-service"
  task_family     = "my-family"
  image           = "${module.ecr.repository_url}:latest"
  cluster_id      = module.ecs_cluster.cluster_id
}

module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
  sg_name = "web-sg"
}

module "ec2" {
  source         = "./modules/ec2"
  instance_type  = "t2.micro"
  subnet_ids = module.subnets.public_subnet_id
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  vpc_name = "my-vpc"
}

module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "route_table" {
  source           = "./modules/route-table"
  vpc_id           = module.vpc.vpc_id
  igw_id           = module.vpc.igw_id
  public_subnet_id = module.subnets.public_subnet_id
}

module "ecr" {
  source = "./modules/ecr"
  repository_name   = "ecrrepo-https-server"
}
