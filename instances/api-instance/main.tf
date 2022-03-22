provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_instance" "api" {
  ami           = var.instance_ami
  instance_type = var.instance_type

  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install httpd -y
    sudo systemctl enable httpd
    sudo systemctl start httpd
    echo "<html><body><div>Hello, world!</div></body></html>" > /var/www/html/index.html
    EOF

  tags = var.tags
}