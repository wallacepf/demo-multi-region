variable "aws_region" {}
variable "cidr_block" {}
variable "subnet_dev" {}
variable "subnet_staging" {}
variable "subnet_prod" {}
variable "inst_size" {}
variable "inst_key_name" {}
variable "inst_name" {}

variable "inst_count" {
  default = "2"
}

variable "inst_common_tags" {
  type = map(string)
  default = {
    "Description" : "Computing Tier",
    "Owner" : "Platform Team"
  }
}