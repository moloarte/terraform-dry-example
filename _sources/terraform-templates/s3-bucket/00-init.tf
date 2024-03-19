data "terraform_remote_state" "kms" {
  count   = var.enabled ? 1 : 0
  backend = "s3"

  config = {
    bucket  = var.remote_states_bucket
    key     = format("states/%s/00-base/kms/terraform.tfstate", var.region)
    region  = var.region
    profile = var.profile
  }
}