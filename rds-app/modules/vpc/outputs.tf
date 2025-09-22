output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "ID de la Subnet Publica"
  value       = aws_subnet.public.id
}

output "private_subnet_ids" {
  description = "IDs de la Subnets Privadas"
  value       = aws_subnet.private[*].id
}

output "public_route_table_id" {
  value = aws_route_table.public.id
}

output "private_route_table_id" {
  value = aws_route_table.private.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.this.id
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}