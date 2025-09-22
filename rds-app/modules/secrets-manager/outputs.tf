output "secret_id" {
  description = "ID del secreto en Secrets Manager"
  value       = aws_secretsmanager_secret.db_credentials.id
}

output "secret_arn" {
  description = "ARN del secreto en Secrets Manager"
  value       = aws_secretsmanager_secret.db_credentials.arn
}

output "secret_name" {
  description = "Nombre del secreto en Secrets Manager"
  value       = aws_secretsmanager_secret.db_credentials.name
}