output "id" {
  value = var.enabled ? module.s3.0.s3_bucket_id : ""
}

output "arn" {
  value = var.enabled ? module.s3.0.s3_bucket_arn : ""
}

output "bucket_domain_name" {
  value = var.enabled ? module.s3.0.s3_bucket_bucket_domain_name : ""
}

output "bucket_regional_domain_name" {
  value = var.enabled ? module.s3.0.s3_bucket_bucket_regional_domain_name : ""
}

output "kms_key_arn" {
  value = var.enabled ? try(data.terraform_remote_state.kms.0.outputs.keys[ var.kms_key_name ].arn, local.default_kms) : ""
}

output "website_domain" {
  value = var.enabled ? module.s3.0.s3_bucket_website_domain : ""
}

output "website_endpoint" {
  value = var.enabled ? module.s3.0.s3_bucket_website_endpoint : ""
}
