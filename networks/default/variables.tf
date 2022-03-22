variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-2"
}
variable "cidr_block_range" {
  description = "The CIDR block for the VPC"
  default = "10.1.0.0/16"
}
variable "subnet_cidr_block_range" {
  description = "The CIDR block for public subnet of VPC"
  default = "10.1.0.0/24"
}
variable "environment_tag" {
  description = "Environment tag"
  default = ""
}
#variable "public_key_path" {
#  description = "Public key path"
#  s3 = "~/.ssh/id_rsa.pub"
#}