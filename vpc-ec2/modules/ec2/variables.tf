variable "project_name" {
  description = "Nombre del proyecto"
  type = string
}

variable "ami_id" {
  description = "AMI de la instancia EC2"
  type = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  description = "ID de la Subnet donde desplegar la EC2"
  type = string
}

variable "security_group_id" {
  description = "ID del Security Group a asociar"
  type = string
}

variable "key_name" {
  description = "Nombre de la key pair para SSH"
  type = string
}

