variable "aws_region" {
  description = "AWS region donde se desplegarán los recursos"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
  default     = "asg-alb"
}

variable "vpc_cidr" {
  description = "CIDR para la VPC principal"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Lista de CIDRs para las subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "Lista de CIDRs para las subnets privadas"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "azs" {
  description = "Availability Zones para desplegar la red"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "my_ip" {
  description = "Dirección IP pública del equipo (con /32) que tendrá acceso permitido a los recursos como ssh o http"
  type = string
  default = "138.0.116.30/32"
}


