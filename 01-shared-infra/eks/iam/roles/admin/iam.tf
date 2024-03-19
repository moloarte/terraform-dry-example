data "aws_iam_policy_document" "eks" {
  count = var.enabled ? 1 : 0
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = [var.account_id]
    }
  }
}

resource "aws_iam_role" "eks" {
  count                 = var.enabled ? 1 : 0
  name                  = "${var.environment_name}-${var.name}"
  description           = "Amazon EKS - Cluster role"
  assume_role_policy    = data.aws_iam_policy_document.eks.0.json
  force_detach_policies = true

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "admin_access" {
  role       = aws_iam_role.eks.0.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}