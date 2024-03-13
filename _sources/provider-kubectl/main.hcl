generate "provider-kubectl" {
  path      = "generated-provider-kubectl.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "kubectl" {
  host                   = local.eks_dependency.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(local.eks_dependency.eks_cluster.certificate_authority_data)
  load_config_file       = "false"
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
EOF
}