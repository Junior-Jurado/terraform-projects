output "bucket_name" {
	value = aws_s3_bucket.site.id
}

output "bucket_domain_name" {
  value = aws_s3_bucket.site.bucket_domain_name
}

output "bucket_arn" {
  value = aws_s3_bucket.site.arn
}