variable "project_name" {
  description = "Nombre del proyecto"
  type = string
}

variable "vpc_id" {
	description = "ID de la VPC donde crear los SG"
	type = string
}

variable "my_ip" {
  description = "IP pública para acceso SSH"
  type = string
}

variable "public_subnet_cidr" {
	description = "CIDR de la subnet pública para permitir acceso a la privada"
	type = string
}
