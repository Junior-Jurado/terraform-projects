
variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type = string
}

variable "cidr_block" {
  description = "Rango de la VPC"
  type = string
}

variable "public_subnet_cidr" {
	description = "CIDR para la subnet publica"
	type = string
}

variable "private_subnet_cidr" {
	description = "CIDR para la subnet privada"
	type = string
}

variable "availability_zone" {
  description = "Zona de disponibilidad donde crear las subnets"
  type = string
}