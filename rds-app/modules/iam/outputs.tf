output "ec2_instance_profile_name" {
  description = "Nombre del instance profile para asociar a la EC2"
  value       = aws_iam_instance_profile.ec2_profile.name
}

output "ec2_role_arn" {
  description = "ARN del rol asignado a la EC2"
  value       = aws_iam_role.ec2_role.arn
}