data "template_file" "kms_policy" {
  for_each = var.keys
  template = file(format("${path.module}/policies/${var.environment_name}/${each.value.policy_name}.tpl"))

  vars = {
    account_id  = var.account_id
    environment = var.environment_name
  }
}
