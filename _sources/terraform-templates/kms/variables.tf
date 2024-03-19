variable "keys" {
  description = "List of objects related to custom certificates, that are not automatic generated"
  type        = map(object({
    description                        = string
    key_usage                          = string
    customer_master_key_spec           = string
    bypass_policy_lockout_safety_check = bool
    deletion_window_in_days            = number
    enable_key_rotation                = bool
    tags                               = map(string)
    policy_name                        = optional(string, "default")
  }))
}
