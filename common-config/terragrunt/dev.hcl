inputs = {
  region = "us-east-1"
  profile = "demo_dev"
  bucket = "dev-remote-state-dod24-demo20240312230801118300000001"
  encrypt = true
  kms_key_id = "8cb6940a-3621-4d35-8fae-ba6f57cd39a9"
  dynamodb_table = "dev-terragrunt-lock-table"
}