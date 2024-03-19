variable "account_id" {
  description = "AWS Account ID number of the account that owns or contains the calling entity"
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

variable "region" {
  description = "AWS region of the deployment"
  type        = string
}

variable "profile" {
  description = "AWS credentials profile to manage the deployment via Terraform"
  type        = string
}

variable "environment_name" {
  description = "Name of the environment"
  type        = string
}