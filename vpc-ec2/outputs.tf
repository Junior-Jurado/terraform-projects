# ========================
# VPC & Networking
# ========================
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID de la Subnet pública"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "ID de la Subnet privada"
  value       = module.vpc.private_subnet_id
}

# ========================
# Security Groups
# ========================
output "public_sg_id" {
  description = "ID del Security Group para EC2 pública"
  value       = module.security_group.public_sg_id
}

output "private_sg_id" {
  description = "ID del Security Group para EC2 privada"
  value       = module.security_group.private_sg_id
}

# ========================
# EC2 Instances
# ========================
output "public_ec2_public_ip" {
  description = "IP pública de la EC2 pública"
  value       = module.ec2.public_ec2_public_ip
}

output "public_ec2_private_ip" {
  description = "IP privada de la EC2 pública"
  value       = module.ec2.public_ec2_private_ip
}

output "private_ec2_private_ip" {
  description = "IP privada de la EC2 privada"
  value       = module.ec2.private_ec2_private_ip
}
