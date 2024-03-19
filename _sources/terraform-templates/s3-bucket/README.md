# Description

This wrapper will by default:

* Make your bucket private
* Encrypt your S3 bucket with the `$env-general-s3-key` KMS key
* Expose the KMS key's ARN over the output

With this wrapper you can:

* Set Lifecycle rules
* Enable versioning or MFA
* Set a personal KMS for server side encryption
* Enforce deletion
* Set up the S3 static website property
* Define the ownership of the objects

# Terragrunt Configuration

## Simple

```json
{
  "enabled": true,
  "bucket_name": "dev-demo",
  "versioning": {
    "enabled": true
  },
  "lifecycle_rules": [
    {
      "id": "demoID",
      "enabled": true,
      "filter": {
        "prefix": "demo/"
      },
      "expiration": {
        "days": 365
      }
    }
  ],
  "block_public_acls": true,
  "block_public_policy": true,
  "ignore_public_acls": true,
  "restrict_public_buckets": true,
  "tags": {}
}
```

## S3 static website

Just integrate this block inside your configuration

```json
{
  "website": {
    "index_document": "index.html"
  }
}
```

You can attach a policy by using  `data "aws_iam_policy_document"` and `resource "aws_s3_bucket_policy"`. Inside those
resources you can easily reference to `module.s3.s3_bucket_arn`

Review also if you need to make any changes to the object ownership policy!

## Implement template in your code

use this code snippet in your `terragrunt.hcl` file.

```terraform
include "root" {
  path = find_in_parent_folders()
}
include "provider_aws" {
  path = format("%s/_sources/generated-files/providers/aws/main.hcl", get_path_to_repo_root())
}
include "additional_variables" {
  path = format("%s/_sources/generated-files/additional-variables.hcl", get_path_to_repo_root())
}
terraform {
  source = format("%s/_sources/terraform-templates/s3-bucket//", path_relative_from_include("root"))
}
```

## Terraform Import

```bash
terragrunt import 'module.s3[0].aws_s3_bucket.this[0]' $bucket-name
terragrunt import 'module.s3[0].aws_s3_bucket_acl.this[0]'  $bucket-name
terragrunt import 'module.s3[0].aws_s3_bucket_server_side_encryption_configuration.this[0]' $bucket-name
terragrunt import 'module.s3[0].aws_s3_bucket_versioning.this[0]' $bucket-name
```
