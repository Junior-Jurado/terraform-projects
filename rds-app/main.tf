module "vpc" {
  source               = "./modules/vpc"
  project_name         = var.project_name
  cidr_block           = "10.0.0.0/16"
  public_subnet_cidr   = "10.0.1.0/24"
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]
  availability_zone    = "us-east-1a"
}

module "security_group" {
  source             = "./modules/security-group"
  project_name       = var.project_name
  vpc_id             = module.vpc.vpc_id
  my_ip              = "138.0.116.30/32"
  public_subnet_cidr = "10.0.1.0/24"
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "ec2" {
  source               = "./modules/ec2"
  project_name         = var.project_name
  ami_id               = "ami-00ca32bbc84273381"
  instance_type        = "t2.micro"
  public_subnet_id     = module.vpc.public_subnet_id
  private_subnet_id    = module.vpc.private_subnet_ids[0]
  public_sg_id         = module.security_group.public_sg_id
  key_name             = "my-key-pair"
  iam_instance_profile = module.iam.ec2_instance_profile_name

  depends_on = [module.rds]

  db_username = module.rds.db_username
  db_password = module.rds.db_password
  db_endpoint = module.rds.db_endpoint
  db_name     = module.rds.db_name
  db_port     = module.rds.db_port
}

module "rds" {
  source             = "./modules/rds"
  project_name       = var.project_name
  private_subnet_ids = module.vpc.private_subnet_ids
  rds_sg_id          = module.security_group.rds_sg_id
}


module "cloudwatch" {
  source            = "./modules/cloudwatch"
  project_name      = var.project_name
  retention_in_days = 1
}

module "secrets_manager" {
  source       = "./modules/secrets-manager"
  project_name = var.project_name

  db_username = module.rds.db_username
  db_password = module.rds.db_password
  db_host     = module.rds.db_endpoint
  db_port     = module.rds.db_port
  db_name     = module.rds.db_name
}
