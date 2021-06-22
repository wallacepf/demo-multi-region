provider "aws" {
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
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