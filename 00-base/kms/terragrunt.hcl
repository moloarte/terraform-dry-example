include "root" {
  path   = find_in_parent_folders()
  expose = true
}

include "provider_aws" {
  path = format("%s/_sources/generated-files/providers/aws/main.hcl", get_path_to_repo_root())
}

include "additional_variables" {
  path = format("%s/_sources/generated-files/additional-variables.hcl", get_path_to_repo_root())
}

terraform {
  source = format("%s/_sources/terraform-templates/kms", get_path_to_repo_root())
}
