provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_s3_bucket" "terraform_demo" {
  bucket = var.bucket_name

  tags = {
    Environment = var.environment_tag
  }
}