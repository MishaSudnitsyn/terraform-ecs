variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "igw_id" {
  description = "Internet Gateway"
  type        = string
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = list(string)
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
}

resource "aws_route_table_association" "a" {
  count          = length(var.public_subnet_id)
  subnet_id      = var.public_subnet_id[count.index]
  route_table_id = aws_route_table.public.id
}
