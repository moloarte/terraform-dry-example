include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "provider_aws" {
  path = format("%s/_sources/provider-aws/main.hcl", get_path_to_repo_root())
}

terraform {
  source = "tfr:///terraform-aws-modules/eks/aws?version=20.8.3"
}

inputs = {
  cluster_name             = "${include.root.inputs.environment}-main"
  vpc_id                   = dependency.vpc.outputs.vpc_id
  subnet_ids               = dependency.vpc.outputs.private_subnets
  control_plane_subnet_ids = dependency.vpc.outputs.private_subnets
  create_iam_role          = false
  iam_role_arn             = dependency.admin_role.outputs.arn
}

dependency "vpc" {
  config_path = "${get_path_to_repo_root()}/00-base/vpc/network"
}

dependency "admin_role" {
  config_path = "${get_path_to_repo_root()}/01-shared-infra/eks/iam/roles/admin"
}