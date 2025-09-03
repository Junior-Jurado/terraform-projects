terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Provider para us-east-1 (El ACM debe crearse en us-east-1 para CloudFront)
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}