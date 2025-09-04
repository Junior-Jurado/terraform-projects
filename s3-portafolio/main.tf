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

# Politica de acceso: Bloquear acceso público ya lo hicimos; ahora se activa la politica para permitir a CloudFront acceso (servicio Principal)
# acceder solo si la peticion viene desde la distribucion concreta (condicion AWS:SourceArn)

resource "aws_s3_bucket_policy" "allow_cloudfront" {
	bucket = module.s3.bucket_name

	policy = jsonencode({
		Version = "2012-10-17"
		Statement = [
			{
				Sid = "AllowCloudFrontServicePrincipalReadOnly"
				Effect = "Allow"
				Principal = {
					Service = "cloudfront.amazonaws.com"
				}
				Action = "s3:GetObject"
				Resource = "${module.s3.bucket_arn}/*"
				Condition = {
					StringEquals = {
						"AWS:SourceArn" = module.cloudfront.distribution_arn
					}
				}
			}
		]
	})  
}

# CloudFront alias record: para CloudFront el zone_id del alias target es constante
# (zone ID global de CloudFront: "Z2FDTNDATAQYW2")
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.existing.zone_id
  name = local.fqdn
  type = "A"

  alias {
	name = module.cloudfront.distribution_domain_name
	zone_id = "Z2FDTNDATAQYW2"
	evaluate_target_health = false 
  }
}