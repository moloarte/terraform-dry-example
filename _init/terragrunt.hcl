include "root" {
  path = find_in_parent_folders()
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
      "state",
      "force-unlock"
    ]

    env_vars = {
      TF_DATA_DIR         = format("%s/.terraform/%s", get_terragrunt_dir(), get_env("TF_VAR_env_name"))
      TF_PLUGIN_CACHE_DIR = format("%s/.terraform.d/plugin-cache/", get_repo_root())
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
      "destroy-all"
    ]

    arguments = [
      format("-var-file=%s/common-config/terraform/%s.json", get_repo_root(), get_env("TF_VAR_env_name")),
      format("-var-file=%s/config/%s.json", get_terragrunt_dir(), get_env("TF_VAR_env_name")),
      "-compact-warnings"
    ]

    env_vars = {
      TF_DATA_DIR         = format("%s/.terraform/%s", get_terragrunt_dir(), get_env("TF_VAR_env_name"))
      TF_PLUGIN_CACHE_DIR = format("%s/.terraform.d/plugin-cache/", get_repo_root())
    }
  }
}
