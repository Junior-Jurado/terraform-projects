output "log_group_name" {
  description = "Nombre del log group creado"
  value = aws_cloudwatch_log_group.app_log_group.name
}

output "log_stream_name" {
  description = "Nombre del log stream creado"
  value = aws_cloudwatch_log_group.app_log_group.name
}