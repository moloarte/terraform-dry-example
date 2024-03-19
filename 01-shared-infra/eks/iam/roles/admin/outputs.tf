output "arn" {
  value = var.enabled ? aws_iam_role.eks.0.arn : ""
}