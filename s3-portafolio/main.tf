locals {
  fqdn        = var.subdomain == "" ? var.domain_name : "${var.subdomain}.${var.domain_name}"
  bucket_name = lower("${var.project_name}-${replace(local.fqdn, ".", "-")}")
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = local.bucket_name
  tags = {
    Project = var.project_name
    FQDN    = local.fqdn
  }
}

module "route53" {
  source = "./modules/route53"
  domain_name = var.domain_name
}

module "acm" {
	source = "./modules/acm"
	fqdn = local.fqdn
	zone_id = module.route53.zone_id
	
	providers = {
	  aws = aws.us_east_1
	}
}