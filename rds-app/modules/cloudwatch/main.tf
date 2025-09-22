resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/${var.project_name}/app"
  retention_in_days = var.retention_in_days

  tags = {
    Project = var.project_name
  }
}

resource "aws_cloudwatch_log_stream" "app_log_stream" {
  name           = "${var.project_name}-app-stream"
  log_group_name = aws_cloudwatch_log_group.app_log_group.name
}