generate "provider-kubernetes" {
  path = "generated-provider-kubernetes.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "kubernetes" {
  host                   = local.eks_dependency.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(local.eks_dependency.eks_cluster.certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--profile",
      var.profile,
      "--cluster-name",
      local.eks_dependency.eks_cluster.id,
      "--region",
      var.region,
      "--role-arn",
      local.eks_dependency.eks_admin_role.arn,
    ]
  }
}

data "terraform_remote_state" "kubernetes_cluster" {
  for_each = {
    eks_cluster    = "infrastructure/$${var.region}/01-shared-infra/eks/clusters/main"
    eks_admin_role = "infrastructure/$${var.region}/01-shared-infra/eks/iam/roles/admin"
  }
  backend = "s3"

  config = {
    bucket  = var.remote_states_bucket
    key     = "$${each.value}/terraform.tfstate"
    region  = var.remote_states_bucket_region
    profile = var.profile
  }
}

locals {
  eks_dependency = {for k, v in data.terraform_remote_state.kubernetes_cluster : k => v.outputs}
  kubecost_labels = {
    infra = lower(var.default_tags.Infra)
    team  = lower(lookup(var.tags, "Team", "devops"))
  }
}
EOF
}