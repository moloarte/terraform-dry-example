generate "provider-helm" {
  path      = "generated-provider-helm.tf"
  if_exists = "overwrite"
  contents  = <<-EOF
  provider "helm" {
    kubernetes {
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
  }
  EOF
}