resource "aws_s3_bucket" "site" {
  bucket = var.bucket_name
  tags = var.tags
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
	suffix = "index.html"
  }

  error_document {
	key = "index.html"
  }
}

resource "aws_s3_bucket_versioning" "site_versioning" {
  bucket = aws_s3_bucket.site.id

  versioning_configuration {
	status = "Enabled"
  }
}

resource "aws_s3_bucket_ownership_controls" "site_ownership" {
  bucket = aws_s3_bucket.site.id
  rule {
	object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_public_access_block" "site_public_block" {
  bucket = aws_s3_bucket.site.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

