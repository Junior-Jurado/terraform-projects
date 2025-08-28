output "vpc_id" {
	description = "ID de la VPC creada"
	value = module.vpc.vpc_id  
}

output "public_subnet_id" {
	value = module.vpc.public_subnet_id  
}

output "private_subnet_id" {
	value = module.vpc.private_subnet_id
}

output "public_sg_id" {
	value = module.security_group.public_sg_id  
}

output "private_sg_id" {
  value = module.security_group.private_sg_id
}

output "public_ec2_ip" {
  value = module.ec2_public.public_ec2_ip
}