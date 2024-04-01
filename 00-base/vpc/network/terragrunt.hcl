include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "configuration" {
  path   = format("./config/%s.hcl", get_env("TF_VAR_env_name"))
  expose = true
}

include "provider_aws" {
  path = "${get_path_to_repo_root()}/_sources/generated-files/providers/aws/main.hcl"
}

terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.5.3"
}

inputs = merge(include.configuration.inputs,
  {
    name = "${include.root.inputs.environment_name}-my-demo-vpc"
  }, )

