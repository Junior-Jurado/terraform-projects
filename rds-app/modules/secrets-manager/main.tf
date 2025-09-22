resource "random_id" "suffix" {
  byte_length = 4
}
resource "aws_secretsmanager_secret" "db_credentials" {
  name = "db_designacion_tareas_credentials"
}

resource "aws_secretsmanager_secret_version" "db_credentials_value" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = var.db_host
    port     = var.db_port
    database = var.db_name
  })
}