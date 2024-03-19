inputs = {
  region = "us-east-1"
  profile = "demo_uat"
  bucket = "uat-remote-state-dod24-demo20240316220901439900000001"
  encrypt = true
  kms_key_id = "cd9bfa27-0150-494c-93f3-49f28f27ff4c"
  dynamodb_table = "uat-terragrunt-lock-table"
}