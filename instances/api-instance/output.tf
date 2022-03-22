output "instance_id" {
  description = "ID of EC2 instance"
  value       = aws_instance.api.id
}