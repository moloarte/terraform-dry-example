data "terraform_remote_state" "dependency" {
  for_each = {
    docker_secret = "states/${var.region}/01-shared-infra/secrets-manager/docker-auth"
  }

  backend = "s3"

  config = {
    bucket  = var.remote_states_bucket
    key     = "${each.value}/terraform.tfstate"
    region  = var.remote_states_bucket_region
    profile = var.profile
  }
}

locals {
  dependency = {for k, v in data.terraform_remote_state.dependency : k => v.outputs}
}
