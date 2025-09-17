module "vpc" {
  source              = "./modules/vpc"
  project_name        = var.project_name
  cidr_block          = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
}

module "security_group" {
  source             = "./modules/security-group"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  my_ip              = "138.0.116.30/32"
  public_subnet_cidr = "10.0.1.0/24"
}

module "ec2" {
  source            = "./modules/ec2"
  project_name      = var.project_name
  ami_id            = "ami-00ca32bbc84273381"
  instance_type     = "t2.micro"
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  public_sg_id      = module.security_group.public_sg_id
  private_sg_id     = module.security_group.private_sg_id
  key_name          = "my-key-pair"
}

module "rds" {
  source             = "./modules/rds"
  project_name       = var.project_name
  private_subnet_ids = [module.vpc.private_subnet_id]
  private_sg_id      = module.security_group.private_sg_id

}

