output "name" {
  value = var.name
}

output "priority_classes" {
  value = [ for class in kubernetes_priority_class.classes : class.id ]
}

output "docker_auth_enabled" {
  value = var.docker_auth_enabled
}