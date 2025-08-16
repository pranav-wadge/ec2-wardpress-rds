terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-south-1"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "aws_instance" "app_server" {
  ami           = "ami-00bb6a80f01f03502"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  key_name = "my-key"

  root_block_device {
    volume_type = "gp3"
    volume_size = 10
  }

  tags = {
    Name = "My-server"
  }
}

resource "aws_db_parameter_group" "myrds_params" {
  name   = "myrds-params"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

resource "aws_db_instance" "myrds" {
  allocated_storage   = var.dbstorage
  storage_type        = "gp3"
  identifier          = "rdstf"
  engine              = "mysql"
  engine_version      = "8.0.40"
  instance_class      = "db.t3.micro"
  username            = var.db_username
  password            = var.db_password
  username            = "pranav"
  password            = "pranav1234"
  publicly_accessible = false
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  parameter_group_name   = aws_db_parameter_group.myrds_params.name

  tags = {
    Name = "MyRDS"
  }
}

resource "aws_security_group" "TF_SG" {
  name        = "security-group-ec2"
  description = "Allow web and SSH access"
  vpc_id      = "vpc-035c6c65b2313705f"

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "EC2-SG"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow EC2 to connect to RDS"
  vpc_id      = "vpc-035c6c65b2313705f"

  ingress {
    description     = "MySQL access from EC2"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.TF_SG.id]  
    security_groups = [aws_security_group.TF_SG.id]  # Allow access from EC2 Security Group
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-SG"
  }
}


resource "cloudflare_record" "portfolio_subdomain" {
  zone_id = var.cloudflare_zone_id
  name    = "pranav"
  value   = aws_instance.app_server.public_ip
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "local_file" "inventory" {
  filename = "ansible/inventory.ini"
  content  = <<-EOT
    [server]
    ${aws_instance.app_server.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/pranav/Downloads/my-key.pem
  EOT
}

output "instance_public_ip" {
  value = aws_instance.app_server.public_ip
}

output "portfolio_url" {
  value = "http://pranav.pranavwadge.cloud"
}

output "rds_endpoint" {
  value = aws_db_instance.myrds.endpoint
}
