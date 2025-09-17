output "public_ec2_public_ip" {
  description = "IP pública de la EC2 pública"
  value       = aws_instance.public_ec2.public_ip
}

output "public_ec2_private_ip" {
  description = "IP privada de la EC2 pública"
  value       = aws_instance.public_ec2.private_ip
}

output "private_ec2_private_ip" {
  description = "IP privada de la EC2 privada"
  value       = aws_instance.private_ec2.private_ip
}
