variable "name" {
  description = "Name of the namespace and prefix of the priority class name"
  type        = string
}

variable "labels" {
  description = "Optional labeling for the namespace resource"
  type        = map(string)
  default     = {}
}

variable "priority_classes" {
  description = "Priority Classes configuration"
  type        = map(object({
    description = string
    value       = number
  }))
  default = {}
}

variable "docker_auth_enabled" {
  description = "Add the docker auth secret to this namespace"
  type        = bool
  default     = false
}