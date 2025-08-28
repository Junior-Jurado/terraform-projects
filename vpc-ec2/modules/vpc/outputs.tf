output "vpc_id" {
  description = "ID de la VPC creada"
  value = aws_vpc.this
}

output "public_subnet_id" {
  description = "ID de la Subnet Pública"
  value = aws_subnet.public.id
}

output "private_subnet_id" {
	description = "ID de la Subnet Privada"
	value = aws_subnet.private.id
}