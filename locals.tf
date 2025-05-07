locals {
    env = terraform.workspace
    vpc_name = lower(var.vpc_name)
    s3_bucket = lower(var.s3_bucket)
}