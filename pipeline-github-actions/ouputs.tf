output "cloudfront_url" {
  description = "URL pública del sitio"
  value = aws_cloudfront_distribution.this.domain_name
}