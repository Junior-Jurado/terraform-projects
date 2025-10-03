module "network" {
  source = "./modules/network"

  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
  azs            = var.azs
  project_name   = var.project_name
}

module "security" {
	source = "./modules/security"

	vpc_id = module.network.vpc_id
	my_ip = var.my_ip
	project_name = var.project_name
}