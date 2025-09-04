resource "aws_cloudfront_origin_access_control" "oac" {
  name          = "${var.aliases[0] != "" ? replace(var.aliases[0], ".", "-") : "oac"}"
  description   = "OAC for S3 origin"
  origin_access_control_origin_type   = "s3"
  signing_protocol = "sigv4"
  signing_behavior = "always"
}

resource "aws_cloudfront_distribution" "site" {
	depends_on = [var.acm_certificate_arn]
	enabled = true
	is_ipv6_enabled = true
	comment = "CloudFront for ${join(",", var.aliases)}"

	origin {
		domain_name = var.bucket_domain_name
		origin_id = "s3-${var.bucket_domain_name}"

		# usar OAC
		origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
	}

	default_cache_behavior {
	  target_origin_id = "s3-${var.bucket_domain_name}"
	  viewer_protocol_policy = "redirect-to-https"
	  allowed_methods = ["GET", "HEAD", "OPTIONS"]
	  cached_methods = ["GET", "HEAD"]
	  compress = true

	  forwarded_values {
		query_string = false
		cookies {
		  forward = "none"
		}
	  }
	}


	default_root_object = "index.html"

	# SPA: devolver index.html para 403
	custom_error_response {
	  error_code = 403
	  response_code = 200
	  response_page_path = "/index.html"
	}

	custom_error_response {
	  error_code = 404
	  response_code = 200
	  response_page_path = "/index.html"
	}

	restrictions {
	  geo_restriction {
		restriction_type = "none"
	  }
	}	

	viewer_certificate {
	  # Si pasas ACM ARN, lo usa; si lo dejas vacío, CloudFront usa certificado por defecto (*.cloudfront.net)
	  acm_certificate_arn = var.acm_certificate_arn != "" ? var.acm_certificate_arn : null
	  ssl_support_method = var.acm_certificate_arn != "" ? "sni-only" : null
	  minimum_protocol_version = var.acm_certificate_arn != "" ? "TLSv1.2_2021" : null
	}

	aliases = var.aliases

	price_class = var.price_class

	lifecycle {
	  create_before_destroy = true
	}

	tags = {
		"ManageBy" = "terraform"
	}
}
