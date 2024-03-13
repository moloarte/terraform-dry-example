data aws_default_tags "this" {}
locals {
  annotations = {
    "managed-by"       = var.default_tags[ "Managed-by" ]
    "terraform-config" = data.aws_default_tags.this.tags[ "Terraform-config" ]
  }
}

resource "kubernetes_namespace" "namespace" {
  count = var.enabled ? 1 : 0
  metadata {

    annotations = merge(
      local.annotations, tomap({
        "description" = "Namespace for ${var.name} resources in the ${var.environment_name} environment"
      })
    )

    labels = var.labels
    name   = var.name
  }
}

resource "kubernetes_priority_class" "classes" {
  for_each = var.priority_classes

  value       = each.value.value
  description = each.value.description
  metadata {
    name        = "${var.name}-${each.key}"
    annotations = merge(
      local.annotations, tomap({ "description" = each.value.description } )
    )
  }
}
