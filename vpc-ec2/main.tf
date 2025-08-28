module "vpc" {
	source = "./modules/vpc"
	project_name = var.project_name
	cidr_block = "10.0.0.0/16" 
	public_subnet_cidr = "10.0.1.0/24"
	private_subnet_cidr = "10.0.2.0/24"
	availability_zone = "us-east-1a"
}