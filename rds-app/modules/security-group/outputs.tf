output "public_sg_id" {
  description = "ID del SG para la instacia EC2 pública"
  value       = aws_security_group.public_sg.id
}

output "rds_sg_id" {
  description = "ID del SG para RDS"
  value       = aws_security_group.rds_sg.id
}