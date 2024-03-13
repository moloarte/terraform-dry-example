include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "provider_aws" {
  path = "${get_path_to_repo_root()}/_sources/provider-aws/main.hcl"
}

terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.5.3"
}

inputs = {
  name   = "${include.root.inputs.environment}-my-demo-vpc"
}
