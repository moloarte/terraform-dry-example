variable "tables" {
  type = map(object({
    hash_key  = string
    attribute = list(object({
      name = string
      type = string
    }))
    range_key                = optional(string)
    billing_mode             = optional(string)
    global_secondary_indexes = optional(list(object({
      hash_key        = string
      name            = string
      projection_type = string
      range_key       = string
    })))
    enable_point_in_time_recovery = optional(bool)
    read_capacity                 = optional(number)
    server_side_encryption = optional(object({
      enabled     = bool
      kms_key_id = optional(string)
    }))
    stream_enabled   = optional(bool)
    stream_view_type = optional(string)
    table_class      = optional(string)
    tags             = map(any)
    write_capacity   = optional(number)
  }))
}