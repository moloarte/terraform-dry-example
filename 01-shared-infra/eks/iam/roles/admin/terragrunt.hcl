include "root" {
  path = find_in_parent_folders()
}

include "provider_aws" {
  path = format("%s/_sources/provider-aws/main.hcl", get_path_to_repo_root())
}

include "additional_variables" {
  path = format("%s/_sources/additional-variables/main.hcl", get_path_to_repo_root())
}