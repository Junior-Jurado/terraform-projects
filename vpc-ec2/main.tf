module "vpc" {
	source = "./modules/vpc"
	project_name = var.project_name
	cidr_block = "10.0.0.0/16" 
	public_subnet_cidr = "10.0.1.0/24"
	private_subnet_cidr = "10.0.2.0/24"
	availability_zone = "us-east-1a"
}

module "security_group" {
	source = "./modules/security-group"
	project_name = var.project_name
	vpc_id = module.vpc.vpc_id
	my_ip = "138.0.116.30/32"
	public_subnet_cidr = "10.0.1.0/24"
}