output "db_endpoint" {
  description = "Endpoint del RDS PostgreSQL"
  value = aws_db_instance.postgres.endpoint
}

output "db_username" {
  description = "Usuario administrador de la base de datos"
  value = var.db_username
}

output "db_password" {
  description = "Password generado para la base de datos"
  value = random_password.db_password.result
  sensitive = true
}

output "db_port" {
  description = "Puerto de la base de datos"
  value = var.db_port
}

output "db_name" {
	description = "Nombre de la base de datos"
	value = var.db_name
}