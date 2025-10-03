variable "vpc_cidr" {
  description = "CIDR para la VPC principal"
  type        = string
}

variable "public_subnets" {
  description = "Lista de CIDRs para las subnets públicas"
  type        = list(string)
}

variable "private_subnets" {
  description = "Lista de CIDRs para las subnets privadas"
  type        = list(string)
}

variable "azs" {
  description = "Availability Zones para desplegar la red"
  type        = list(string)
}

variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}
