
variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type        = string
}

variable "cidr_block" {
  description = "Rango de la VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR para la subnet publica"
  type        = string
}

variable "private_subnet_cidrs" {
  description = "CIDR para la subnet privada"
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "availability_zones" {
  description = "Zonas de disponibilidad donde crear las subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "availability_zone" {
  description = "Zona de disponibilidad donde crear las subnets"
  type        = string
  default     = "us-east-1a"
}