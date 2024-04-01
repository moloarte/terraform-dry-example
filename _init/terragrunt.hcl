locals {
  environment_vars = read_terragrunt_config("${get_path_to_repo_root()}/common-config/terragrunt/${get_env("TF_VAR_env_name")}.hcl")
}

inputs = {
  tg_path_relative_from_root = get_path_to_repo_root()
  environment_name           = get_env("TF_VAR_env_name")
  region                     = local.environment_vars.inputs.region
  profile                    = local.environment_vars.inputs.profile
  remote_states_bucket       = local.environment_vars.inputs.bucket
}

remote_state {
  backend = "local"
  config  = {
    path = format("%s/tfstate/terraform_%s.tfstate", get_terragrunt_dir(), get_env("TF_VAR_env_name"))
  }
}

terraform {
  extra_arguments "init" {
    commands = [
      "init",
      "output",
    ]

    env_vars = {
      TF_DATA_DIR         = "${get_terragrunt_dir()}/.terraform/${get_env("TF_VAR_env_name")}"
      TF_PLUGIN_CACHE_DIR = "${get_path_to_repo_root()}/.terraform.d/plugin-cache/"
    }
  }

  extra_arguments "common_var" {
    commands = [
      "apply",
      "plan",
      "import",
      "destroy",
      "refresh",
    ]

    arguments = [
      "-compact-warnings"
    ]

    optional_var_files = [
      "${get_terragrunt_dir()}/config/${get_env("TF_VAR_env_name")}.json"
    ]

    required_var_files = [
      "${get_path_to_repo_root()}/common-config/terraform/${get_env("TF_VAR_env_name")}.json",
    ]

    env_vars = {
      TF_DATA_DIR         = "${get_terragrunt_dir()}/.terraform/${get_env("TF_VAR_env_name")}"
      TF_PLUGIN_CACHE_DIR = "${get_path_to_repo_root()}/.terraform.d/plugin-cache/"
    }
  }
}
