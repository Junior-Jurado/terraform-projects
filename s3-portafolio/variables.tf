variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "portafolio"
}

variable "domain_name" {
  type        = string
  description = "Dominio raíz (ej:GermanJurado.cloud)"
}

variable "subdomain" {
  type        = string
  description = "Subdominio (ej: www). vacio para apex"
  default     = "www"
}

variable "hosted_zone_name" {
  type        = string
  description = "Nombre de la Hosted Zone Pública (ej: GermanJurado.com.)"
}