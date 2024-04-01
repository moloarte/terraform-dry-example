output "kms_key_id" {
  value = aws_kms_key.kms.id
}

output "kms_key_alias" {
  value = aws_kms_alias.kms.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.s3.id
}

output "dynamo_table_name" {
  value = aws_dynamodb_table.terraform_state_lock.name
}