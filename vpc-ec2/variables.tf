# Acá se definen las variables globales

variable "project_name" {
	description = "Nombre del proyecto para etiquetar recursos"
	type = string
	default = "vpc-ec2"
}

variable "region" {
  description = "Región de AWS a desplegar"
  type = string
  default = "us-east-1"
}
