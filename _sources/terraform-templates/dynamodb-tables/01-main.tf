resource "aws_dynamodb_table" "table" {
  for_each = var.tables
  name         = each.key
  hash_key     = each.value.hash_key
  range_key    = try(each.value.range_key, null)
  billing_mode = try(each.value.billing_mode, "PAY_PER_REQUEST")

  point_in_time_recovery {
    enabled = try(each.value.enable_point_in_time_recovery, false)
  }

  read_capacity  = try(each.value.read_capacity, null)
  write_capacity = try(each.value.write_capacity, null)

  server_side_encryption {
    enabled     = try(each.value.server_side_encryption["enabled"], true)
    kms_key_arn = try(local.dependency.kms.keys[each.value.server_side_encryption["kms_key_id"]].arn, null)
  }

  dynamic "attribute" {
    for_each = each.value.attribute
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  dynamic "global_secondary_index" {
    for_each = each.value.global_secondary_indexes == null ? [] : each.value.global_secondary_indexes
    content {
      hash_key        = global_secondary_index.value["hash_key"]
      name            = global_secondary_index.value["name"]
      projection_type = global_secondary_index.value["projection_type"]
      range_key       = global_secondary_index.value["range_key"]
    }
  }

  stream_enabled   = try(each.value.stream_enabled, false)
  stream_view_type = try(each.value.stream_view_type, null)
  table_class      = try(each.value.table_class, "STANDARD")

  tags = merge(var.tags, each.value.tags)
}
