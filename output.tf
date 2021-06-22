output "main_vpc" {
  value = aws_vpc.main.id
}

output "default_security_group_id" {
  value = aws_vpc.main.default_security_group_id
}

output "development_subnet_id" {
  value = aws_subnet.development.id
}

output "staging_subnet_id" {
  value = aws_subnet.staging.id
}

output "production_subnet_id" {
  value = aws_subnet.production.id
}

output "development_subnet" {
  value = aws_subnet.development.cidr_block
}

output "staging_subnet" {
  value = aws_subnet.staging.cidr_block
}

output "production_subnet" {
  value = aws_subnet.production.cidr_block
}

output "region" {
  value = var.aws_region
}