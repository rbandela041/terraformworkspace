resource "randon_integer" "pokemon" {
  count = 3
  min   = 1000
  max   = 9999
}

resource "aws_dynamodb_table" "terraformlocks" {
    count = 3
    name = "terraformlocks-${randon_integer.pokemon[count.index].result}"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    tags = {
        Name = "terraformlocks-${randon_integer.pokemon[count.index].result}"
        Env  = local.env
    }
}

resource "aws_s3_bucket" "terraformlocks" {
    count = 3
    bucket = join("-", [local.s3_bucket, terraform.workspace, randon_integer.pokemon[count.index].result])
    tags = {
        Name = join("-", [local.s3_bucket, terraform.workspace, randon_integer.pokemon[count.index].result])
        Env  = local.env
    }

}