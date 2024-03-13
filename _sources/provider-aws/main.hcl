generate "provider-aws" {
  path = "generated-provider-aws.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = var.region
  profile = var.profile

  default_tags {
    tags = merge({"Terraform-config"="https://github.com/SOMEREPO/terraform-dry-example/tree/main/$${var.tg_path_relative_from_root}"},var.default_tags)
  }
}

terraform {
  backend "s3" {}
}

variable "account_id" {
  description = "AWS Account ID number of the account that owns or contains the calling entity"
  type        = string
}

variable "region" {
  description = "AWS region of the deployment"
  type        = string
}

variable "profile" {
  description = "AWS credentials profile to manage the deployment via Terraform"
  type        = string
}

variable "remote_states_bucket" {
  description = "Bucket where environment's remote states are stored"
  type        = string
}

variable "environment_name" {
  description = "Name of the environment"
  type        = string
}

variable "tg_path_relative_from_root" {
  description = "This returns the relative path between the path specified in the root include block and the current terragrunt.hcl file. "
  type        = string
}

variable "default_tags" {
  description = "Default Tags defined in the common-config/terraform/$env.json files"
  type        = map(string)
}

EOF

}