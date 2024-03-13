locals {
  environment_vars = read_terragrunt_config("${get_parent_terragrunt_dir()}/common-config/terragrunt/${get_env("TF_VAR_env_name")}.hcl")
}

inputs = {
  tg_path_relative_from_root = path_relative_to_include("root")
  environment                = get_env("TF_VAR_env_name")
}

remote_state {
  backend = "s3"
  config  = {
    region         = local.environment_vars.inputs.region
    profile        = local.environment_vars.inputs.profile
    bucket         = local.environment_vars.inputs.bucket
    key            = format("states/%s/%s/terraform.tfstate", local.environment_vars.inputs.region, path_relative_to_include())
    encrypt        = local.environment_vars.inputs.encrypt
    dynamodb_table = local.environment_vars.inputs.dynamodb_table
    kms_key_id     = local.environment_vars.inputs.kms_key_id
  }
}

terraform {
  extra_arguments "init" {
    commands = [
      "init",
      "output",
      "state",
      "force-unlock",
      "taint",
      "show"
    ]

    env_vars = {
      TF_DATA_DIR         = format("%s/.terraform/%s", get_terragrunt_dir(), get_env("TF_VAR_env_name"))
      TF_PLUGIN_CACHE_DIR = "${get_parent_terragrunt_dir()}/.terraform.d/plugin-cache/"
    }
  }

  extra_arguments "common_var" {
    commands = [
      "apply",
      "plan",
      "import",
      "push",
      "destroy",
      "refresh",
      "apply-all",
      "destroy-all",
      "console",
    ]

    arguments = [
      "-compact-warnings"
    ]

    optional_var_files = [
      format("%s/config/%s.json", get_terragrunt_dir(), get_env("TF_VAR_env_name"))
    ]

    required_var_files = [
      format("%s/common-config/terraform/%s.json", get_parent_terragrunt_dir(), get_env("TF_VAR_env_name")),
    ]

    env_vars = {
      TF_DATA_DIR         = format("%s/.terraform/%s", get_terragrunt_dir(), get_env("TF_VAR_env_name"))
      TF_PLUGIN_CACHE_DIR = "${get_parent_terragrunt_dir()}/.terraform.d/plugin-cache/"
    }
  }
}
