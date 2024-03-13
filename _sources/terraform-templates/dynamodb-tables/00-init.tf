data "terraform_remote_state" "dependency" {
  for_each = {
    kms               = format("states/%s/00-base/kms", var.region)
  }
  backend = "s3"
  config = {
    bucket  = var.remote_states_bucket
    key     = format("%s/terraform.tfstate", each.value)
    region  = var.remote_states_bucket_region
    profile = var.profile
  }
}

locals {
  dependency = { for k, v in data.terraform_remote_state.dependency : k => v.outputs }
}