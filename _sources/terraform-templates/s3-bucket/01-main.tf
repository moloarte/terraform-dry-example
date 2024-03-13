data "aws_kms_key" "s3" {
  count  = var.enabled ? 1 : 0
  key_id = var.kms_key_name == null ? local.default_kms : format("alias/%s", var.kms_key_name)
}

locals {
  default_kms        = var.enabled ? data.terraform_remote_state.kms.0.outputs.keys[ "${var.environment_name}-general-s3-key" ].arn : ""
  kms_master_key_id  = local.sse_algorithm == "aws:kms" ? data.aws_kms_key.s3.0.arn : null
  bucket_key_enabled = try(var.encryption.bucket_key_enabled, null) == null ? true : var.encryption.bucket_key_enabled
  sse_algorithm      = try(var.encryption.sse_algorithm, null) == null ? "aws:kms" : var.encryption.sse_algorithm
}

module "s3" {
  count = var.enabled ? 1 : 0
  source = "terraform-aws-modules/s3-bucket/aws"

  create_bucket = var.enabled
  bucket        = try(var.bucket_name, null)
  bucket_prefix = try(var.bucket_prefix, null)
  acl           = var.acl

  versioning = {
    status     = var.versioning.enabled
    mfa_delete = var.versioning.mfa_delete
    mfa        = var.versioning.mfa
  }

  server_side_encryption_configuration = {
    rule = {
      bucket_key_enabled  = local.bucket_key_enabled
      apply_server_side_encryption_by_default = {
        kms_master_key_id = local.kms_master_key_id
        sse_algorithm     = local.sse_algorithm
      }
    }
  }

  website                  = var.website
  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets

  force_destroy  = var.force_destroy
  lifecycle_rule = try(var.lifecycle_rules, [ ])
  tags           = var.tags
}
