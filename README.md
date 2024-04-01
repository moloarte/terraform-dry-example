# terraform-dry-example
This is an example created for the DevopsDays 2024 in Krakow.

## How to start

1. Set the environment. `export TF_VAR_env_name=dev`.
2. Update the parameters `common-config/terraform/dev.json`.
2. Update the `_init/config/dev.json` for additional tags
3. Run `terragrunt apply` in the `_init` directory.
4. Take the `s3_bucket_name`, `dynamo_table_name` and `kms_key_id` output and set the value inside `common-config/terragrunt/dev.hcl`.


### _init
This folder contains initial terraform resources including: 
* S3 states bucket
* KMS key for S3 states bucket encryption
* DynamoDB states lock table

State files for these resources are also stored in this folder to prevent terraform from re-creation attempts.
This code must be executed at the very first step of environment initialization and only once.

### JSON or HCL for configuration?

If your configuration is static and does not require environment specific dependencies, go for JSON.  
If you want one standard, go for HCL since it will have you covered.

> [!IMPORTANT]  
> If you add the configuration block in terragrunt.hcl you have to create a HCL file for each environment. Even if the file is empty.


**Configuration Block**
```hcl
include "configuration" {
  path   = format("./config/%s.hcl", get_env("TF_VAR_env_name"))
  expose = true
}
```

### Templates (Wrappers)

Inside the directory `_sources/` we have a collection of different templates that should be used to keep a straightforward
standard on how we set up and configure common resources.