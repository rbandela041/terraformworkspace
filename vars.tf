variable "vpc_cidr" {}
variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}
variable "azs" {}
variable "vpc_name" {}
variable "instance_type" {}
variable "ami" {}
variable "key_name" {}
variable "region" {}
variable "s3_bucket" {}
variable "dynamo_db" {}
variable "test_role_arn" {
  type = string
  default = "arn:aws:iam::811362454422:role/testrole"
}

variable "qa_role_arn" {
  type = string
  default = "arn:aws:iam::811362454422:role/qarole"
}

