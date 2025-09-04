# Usar provider alias para us-east-1 en este módulo
provider "aws" {
  alias = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "cert" {
  provider = aws.us_east_1
  domain_name = var.fqdn
  validation_method = "DNS"

  lifecycle {
	create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  for_each = {
	for dvo in aws_acm_certificate.cert.domain_validation_options : dvo.domain_name => {
		name = dvo.resource_record_name
		type = dvo.resource_record_type
		value = dvo.resource_record_value
	}
  }

  zone_id = var.zone_id
  name = each.value.name
  type = each.value.type
  ttl = 300
  records = [each.value.value]
}

resource "aws_acm_certificate_validation" "cert_validation" {
  provider = aws.us_east_1
  certificate_arn = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}