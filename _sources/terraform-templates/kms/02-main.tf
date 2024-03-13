resource "aws_kms_key" "key" {
  for_each                           = var.keys
  description                        = each.value.description
  key_usage                          = each.value.key_usage
  customer_master_key_spec           = each.value.customer_master_key_spec
  bypass_policy_lockout_safety_check = each.value.bypass_policy_lockout_safety_check
  deletion_window_in_days            = each.value.deletion_window_in_days
  enable_key_rotation                = each.value.enable_key_rotation
  policy                             = data.template_file.kms_policy[each.key].rendered
  tags                               = merge(var.tags,
    tomap({ "Name" = format("${var.environment_name}-${each.key}") }),
    each.value.tags)
}

resource "aws_kms_alias" "aliases" {
  for_each      = {for key, value in aws_kms_key.key : value.tags["Name"] => { id = value.id }}
  name          = format("alias/%s", each.key)
  target_key_id = each.value.id
}
