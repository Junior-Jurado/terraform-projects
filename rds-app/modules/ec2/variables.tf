variable "project_name" {
  description = "Nombre del proyecto"
  type        = string
}

variable "ami_id" {
  description = "AMI de la instancia EC2"
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_id" {
  description = "ID de la Subnet pública"
  type        = string
}

variable "private_subnet_id" {
  description = "ID de la Subnet privada"
  type        = string
}

variable "public_sg_id" {
  description = "ID del Security Group para la EC2 pública"
  type        = string
}

variable "private_sg_id" {
  description = "ID del Security Group para la EC2 privada"
  type        = string
}

variable "key_name" {
  description = "Nombre de la key pair para SSH"
  type        = string
}

variable "iam_instance_profile" {
  description = "IAM instance profile name to attach to the EC2"
  type = string
  default = null
}