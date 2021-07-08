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

module "security_group_ec2" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~>3.0"

  name   = "ec2"
  vpc_id = aws_vpc.main.id
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH Access to EC2 instance"
      cidr_blocks = aws_vpc.main.cidr_block
    }
  ]
  egress_rules = ["all-all"]
  tags         = var.inst_common_tags
}

module "demo-ec2-module" {
  source  = "app.terraform.io/my-demo-account/demo-ec2-module/aws"
  version = "1.0.3"
  
  inst_name = var.inst_name
  inst_size = var.inst_size
  inst_key_name = var.inst_name
  inst_sec_group_id = [module.security_group_ec2.security_group_id]
  inst_subnet_id = aws_subnet.development.id
  inst_common_tags = var.inst_common_tags
}
