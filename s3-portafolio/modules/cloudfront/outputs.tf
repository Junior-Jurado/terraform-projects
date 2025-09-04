output "distribution_id" {
	value = aws_cloudfront_distribution.site.id  
}

output "distribution_domain_name" {
	value = aws_cloudfront_distribution.site.domain_name
}

output "distribution_arn" {
  value = aws_cloudfront_distribution.site.arn
}