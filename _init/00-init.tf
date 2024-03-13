provider "aws" {
  profile = var.profile
  region  = var.region
  default_tags {
    tags = merge({"Terraform-config"="https://github.com/SOMEREPO/terraform-dry-example/tree/main/${var.tg_path_relative_from_root}"},var.default_tags)
  }
}

terraform {
  backend "local" {}
}
