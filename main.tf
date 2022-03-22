terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0"
    }
  }

  #  required_version = ">= 0.14.9"
}

locals {
  eu_region = "eu-central-1"
  us_region = "us-west-2"

  environments = {
    dev   = "development"
    qa    = "release/candidate"
    prod  = "production"
  }

  ami_images = {
    eu = {
      amazon_linux  = "ami-0dcc0ebde7b2e00db" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
      ubuntu        = "ami-0d527b8c289b4af7f" // Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
    }
    us = {
      amazon_linux  = "ami-00ee4df451840fa9d" // Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
      ubuntu        = "ami-0892d3c7ee96c0bf7" // Ubuntu Server 20.04 LTS (HVM), SSD Volume Type
    }
  }

  # global local variables for all files
  common_tags = {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
  }
}

# US region

module "us_uploads_bucket" {
  source = "./others/s3"

  access_key		= var.aws_access_key
  secret_key		= var.aws_secret_key
  region			= var.aws_region
  environment_tag   = local.environments.dev
  bucket_name       = "yura-sultonov-terraform-demo-${local.us_region}"
}

module "us_default_network" {
  source = "./networks/default"

  access_key		= var.aws_access_key
  secret_key		= var.aws_secret_key
  region			= local.us_region
  environment_tag   = local.environments.dev
}

module "eu_default_network" {
  source = "./networks/default"

  access_key		= var.aws_access_key
  secret_key		= var.aws_secret_key
  region			= local.eu_region
  environment_tag   = local.environments.dev
}

module "us_http_security_group" {
  source = "./securityGroups/http"

  access_key		= var.aws_access_key
  secret_key		= var.aws_secret_key
  region			= local.us_region
  vpc_id			= module.us_default_network.vpc_id
  environment_tag = local.environments.dev
}

module "eu_http_security_group" {
  source = "./securityGroups/http"

  access_key		= var.aws_access_key
  secret_key		= var.aws_secret_key
  region			= local.eu_region
  vpc_id			= module.eu_default_network.vpc_id
  environment_tag = local.environments.dev
}

module "us_api_instance" {
  source = "./instances/api-instance"

  access_key		= var.aws_access_key
  secret_key		= var.aws_secret_key
  region			= local.us_region
  instance_ami       = local.ami_images.us.amazon_linux
  instance_type      = "t2.micro"
  subnet_id          = module.us_default_network.public_subnet_id
  security_group_ids = [module.us_http_security_group.sg_22, module.us_http_security_group.sg_80]

  tags = {
    project     = "API",
    environment = local.environments.dev
  }
}

module "eu_api_instance" {
  source = "./instances/api-instance"

  access_key		= var.aws_access_key
  secret_key		= var.aws_secret_key
  region			= local.eu_region
  instance_ami       = local.ami_images.eu.amazon_linux
  instance_type      = "t2.micro"
  subnet_id          = module.eu_default_network.public_subnet_id
  security_group_ids = [module.eu_http_security_group.sg_22, module.eu_http_security_group.sg_80]

  tags = {
    project     = "API",
    environment = local.environments.dev
  }
}

# EU region

module "eu_uploads_bucket" {
  source = "./others/s3"

  access_key		= var.aws_access_key
  secret_key		= var.aws_secret_key
  region			= local.eu_region
  environment_tag   = local.environments.dev
  bucket_name       = "yura-sultonov-demo-${local.us_region}"
}