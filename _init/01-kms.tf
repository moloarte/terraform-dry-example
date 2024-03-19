data "template_file" "kms_policy" {
  template = file("${path.module}/templates/kms-policy.tpl")

  vars = {
    account_id = var.account_id
  }
}

resource "aws_kms_key" "kms" {
  description         = "KMS key for ${var.environment_name} tfstate S3 bucket encryption"
  policy              = data.template_file.kms_policy.rendered
  enable_key_rotation = true

  tags = var.tags
}

resource "aws_kms_alias" "kms" {
  name          = "alias/${var.environment_name}-tfstate-s3-encryption"
  target_key_id = aws_kms_key.kms.key_id
}