resource "aws_s3_bucket" "s3" {
  bucket_prefix = "${var.environment_name}-remote-state-dod24-demo"

  lifecycle {
    prevent_destroy = true
  }

  tags = var.tags
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.s3.id
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.kms.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

data "template_file" "s3_policy" {
  template = file("${path.module}/templates/s3-policy.tpl")

  vars = {
    s3_bucket_arn = aws_s3_bucket.s3.arn
    account_id    = var.account_id
  }
}

resource "aws_s3_bucket_policy" "terraform_state" {
  bucket = aws_s3_bucket.s3.id
  policy = data.template_file.s3_policy.rendered
}

resource "aws_s3_bucket_public_access_block" "s3" {
  bucket                  = aws_s3_bucket.s3.id
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
}