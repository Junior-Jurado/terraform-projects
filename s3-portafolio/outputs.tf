output "bucket_name" {
  value = module.s3.bucket_name
}

output "cloudfront_domain" {
  value = module.cloudfront.distribution_domain_name
}

output "cloudfront_id" {
  value = module.cloudfront.distribution_id
}

output "site_url" {
  value = "https://${local.fqdn}"
}