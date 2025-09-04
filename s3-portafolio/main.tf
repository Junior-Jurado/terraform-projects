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


data "aws_route53_zone" "existing" {
  name         = var.domain_name
  private_zone = false
}

module "acm" {
  source  = "./modules/acm"
  fqdn    = local.fqdn
  zone_id = data.aws_route53_zone.existing.zone_id

  providers = {
    aws = aws.us_east_1
  }
}

module "cloudfront" {
  source              = "./modules/cloudfront"
  bucket_domain_name  = module.s3.bucket_domain_name
  aliases             = [local.fqdn]
  acm_certificate_arn = module.acm.certified_arn
  price_class = "PriceClass_100"
}