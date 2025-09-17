variable "project_name" {
  description = "Nombre del proyecto para etiquetar recursos"
  type = string
}

variable "instance_class" {
  description = "Instance type RDS"
  type = string
  default = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Asigned storage GB"
  type = number
  default = 20
}

variable "db_engine_version" {
  description = "Version of engine PostgreSQL"
  type = string
  default = "15.4"
}


variable "db_username" {
  description = "User admin of database"
  type = string
  default = "admin"
}

variable "db_name" {
  description = "Nombre de la base de datos por defecto"
  type = string
  default = "appdb"
}

variable "db_port" {
  description = "Puerto de la base de datos"
  type = number
  default = 5432
}

variable "private_subnet_ids" {
  description = "IDs de las subnets privadas donde se ubicará el RDS"
  type = list(string)
}

variable "private_sg_id" {
  description = "Security Group ID que permitirá el acceso al RDS"
  type = string
}

