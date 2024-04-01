inputs = {
  "keys" = {
    "general-s3-key" = {
      "description"                        = "KMS key for general encrypting various s3 buckets",
      "key_usage"                          = "ENCRYPT_DECRYPT",
      "customer_master_key_spec"           = "SYMMETRIC_DEFAULT",
      "policy"                             = {},
      "bypass_policy_lockout_safety_check" = false,
      "deletion_window_in_days"            = 30,
      "enable_key_rotation"                = true,
      "tags"                               = {
        "Rfc" = "someReference"
      }
    }
  },
  "tags" = {
    "Department" = "devops"
  }
}