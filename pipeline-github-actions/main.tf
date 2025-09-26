provider "aws" {
  region = var.aws_region
}

# S3 Bucket (privado, usado solo por CloudFront)
resource "aws_s3_bucket" "static_site" {
	bucket = var.bucket_name

	tags = {
	  Name = "static-site"
	  Environment = "dev"
	  Owner = "Junior"
	}
}

# Bloquear acceso publico directo
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.static_site.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

# Subir index.html
resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.static_site.bucket
  key = "index.html"
  source = "index.html"
  content_type = "text/html"
  etag = filemd5("index.html")
}

# OAC para CloudFront
resource "aws_cloudfront_origin_access_control" "this" {
  name = "${var.bucket_name}-oac"
  description = "Control de acceso para CloudFront a S3"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}

# CloudFront Distribution 
resource "aws_cloudfront_distribution" "this" {
  enabled = true
  default_root_object = "index.html"

  origin {
	domain_name = aws_s3_bucket.static_site.bucket_regional_domain_name
	origin_id = aws_s3_bucket.static_site.id
	origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  default_cache_behavior {
	target_origin_id = aws_s3_bucket.static_site.id
	viewer_protocol_policy = "redirect-to-https"
	allowed_methods = ["GET", "HEAD"]
	cached_methods = ["GET", "HEAD"]

	forwarded_values {
	  query_string = false
	  cookies {
		forward = "none"
	  }
	}
  }

  restrictions {
	geo_restriction {
	  restriction_type = "none"
	}
  }

  viewer_certificate {
	cloudfront_default_certificate = true
  }

  tags = {
	Name = "static-site-cdn"
	Environment = "dev"
  }
}