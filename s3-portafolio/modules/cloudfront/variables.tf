variable "bucket_domain_name" {
	type = string
}

variable "aliases" {
  type = list(string)
  default = []
}


variable "acm_certificate_arn" {
  type        = string
  description = "ARN del certificado ACM validado para CloudFront"
  default     = ""
}


variable "price_class" {
  type = string
  default = "PriceClass_100"
}
