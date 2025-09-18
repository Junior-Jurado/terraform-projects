variable "project_name" {
  description = "Nombre del proyecto"
  type = string
}

variable "retention_in_days" {
  description = "Días de retención de logs en CloudWatch"
  type = number
  default = 7
}