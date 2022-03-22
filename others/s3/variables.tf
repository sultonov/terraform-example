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
variable "bucket_name" {}
variable "acl_value" {
  type        = string
  default = "private"
}
variable "environment_tag" {
  description = "Environment tag"
  default = ""
}