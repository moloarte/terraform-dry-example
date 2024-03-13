# Description

This wrapper will create a namespace for your EKS cluster

It will: 
* Create a namespace 

Optionally you can:
* save the docker auth login secret credential for this namespace
* configure priority classes


# Terraform Configuration

## Implement in your code

```terraform
include "root" {
  path = find_in_parent_folders()
  expose = true
}

include "provider_aws" {
  path = format("%s/_sources/provider-aws/main.hcl", get_path_to_repo_root())
}

include "provider_kubernetes" {
  path = format("%s/_sources/provider-kubernetes/main.hcl", get_path_to_repo_root())
}

terraform {
  source = format("%s/_sources/terraform-templates/eks-namespaces//.", path_relative_from_include("root"))
}
```

## Working configuration example

```json
{
  "enabled": true,
  "name": "demo",
  "docker_auth_enabled": true,
  "priority_classes": {
    "infra-node-critical": {
      "description": "Used for critical pods that must not be moved from their current node.",
      "value": 100000100
    },
    "infra-cluster-critical": {
      "description": "Used for critical pods that must not be evicted from their current node.",
      "value": 100000000
    }
  },
  "tags" :{
    "Team": "devops"
  }
}
```