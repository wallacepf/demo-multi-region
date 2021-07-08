provider "aws" {
  region     = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "development" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_dev

  tags = {
    Name = "development"
  }
}

resource "aws_subnet" "staging" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_staging

  tags = {
    Name = "staging"
  }
}

resource "aws_subnet" "production" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_prod

  tags = {
    Name = "production"
  }
}

resource "aws_security_group" "inst_default_rules" {
  name        = "allow_ssh"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

module "demo-ec2-module" {
  source  = "app.terraform.io/my-demo-account/demo-ec2-module/aws"
  version = "1.0.4"
  
  inst_name = var.inst_name
  inst_size = var.inst_size
  inst_key_name = var.inst_name
  inst_sec_group_id = aws_security_group.inst_default_rules
  inst_subnet_id = aws_subnet.development.id
  inst_common_tags = var.inst_common_tags
}
