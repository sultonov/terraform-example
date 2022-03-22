variable "access_key" {
  description = "AWS Access Key"
  type        = string
}
variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
}
variable "region" {
  description = "AWS region"
  type        = string
  default = "us-east-2"
}
variable "instance_type" {
  description = "Type of EC2 instance to use"
  type        = string
}
variable "instance_ami" {
  description = "EC2 instance ami"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
}
variable "security_group_ids" {
  description = "Security group IDs for EC2 instance"
  type        = list(string)
}
variable "tags" {
  description = "Tags for instance"
  type        = map
  default     = {}
}