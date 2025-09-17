output "public_sg_id" {
	description = "ID del SG para la instacia EC2 pública"
	value = aws_security_group.public_sg.id
}

output "private_sg_id" {
	description = "ID del SG para la instancia EC2 privada"
	value = aws_security_group.private_sg.id
}