include "root" {
  path = find_in_parent_folders()
}

include "provider_aws" {
  path = format("%s/_sources/generated-files/providers/aws/main.hcl", get_path_to_repo_root())
}

include "common_variables" {
  path = format("%s/_sources/common-variables/main.hcl", get_path_to_repo_root())
}

dependencies {
  paths =[
    "${get_parent_terragrunt_dir("root")}/01-shared-infra/domains/zones/public"
  ]
}