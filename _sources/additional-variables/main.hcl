generate "additional_variables" {
  path      = "generated-additional-variables.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
variable "enabled" {
  description = "Boolean that defines if a resource is going to be created or not"
  default     = false
  type        = bool
}

variable "tags" {
  description = "Map of tags"
  type        = map(string)
}
EOF
}