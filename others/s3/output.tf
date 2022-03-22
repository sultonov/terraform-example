output "bucket_id" {
  description = "ID of bucket"
  value       = aws_s3_bucket.terraform_demo.id
}