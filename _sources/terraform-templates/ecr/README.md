# Description

This Terraform wrapper will create you an ECR with the option of creating an ECR lifecycle policy.

The lifecycle policy is optional and will only be added if the parameter is specified. By default, it will
keep the last 30 images.

## ECR configuration

This wrapper expects a map of keys called `repos`.
The allowed paramerters are:

* `used_version` - (Optional) Will be added to the output to retrieve the latest approved version of the repository. Important feature for satelite repositories.
* `tags` - (Optional) A map of strings that will add or overwrite any existing tags
* `policy` - (Optional) A map of strings that will enable and manage the lifecycle policy of the ECR repository.
  * `count` - (Optional) the amount of last images to keep.
  * `tagStatus` - (Optional) Determines whether the lifecycle policy rule that you are adding specifies a tag for an image.

```json
{
  "repos": {
    "company/custom-nginx": {},
    "filebeat": {
      "used_version": "7.14.0"
    },
    "company/custom-golang": {
      "used_version": "1.6.0",
      "tags": {
        "Rfc": "some_reference"
      }
    },
    "registrator": {
    }
  }
}
```

# Wrapper usage

```hcl
include "root" {
  path = find_in_parent_folders()
}

include "provider_aws" {
  path = format("%s/_sources/provider-aws/main.hcl", get_path_to_repo_root())
}

include "additional_variables" {
  path = format("%s/_sources/additional-variables/main.hcl", get_path_to_repo_root())
}

terraform {
  source = format("%s/_sources/terraform-templates/ecr//", path_relative_from_include("root"))
}
```


# Wrapper development

This wrapper can always be developed. 
For example, we could improve:
* the ECR repository settings
* the lifecycle settings depending on tagStatus `tagged`

# Import of resource

```bash
# terragrunt import 'aws_ecr_repository.ecr_repository["$name"]' $name
# terragrunt import 'aws_ecr_lifecycle_policy.policy["$name"]' $name
```