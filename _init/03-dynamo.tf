resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "${var.environment_name}-terragrunt-lock-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = var.tags
}