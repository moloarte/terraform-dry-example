##### ECR repos

resource "aws_ecr_repository" "ecr_repository" {
  for_each = var.repos
  name     = each.key

  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.tags, try(each.value.tags, {}))
}

locals {
  default_count = 30
}

resource "aws_ecr_lifecycle_policy" "policy" {
  for_each   = {for name, config in var.repos : name => config.policy if try(config.policy, null) != null}
  repository = aws_ecr_repository.ecr_repository[each.key].name
  policy     = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep the last ${try(each.value.count, 30)} images",
            "selection": {
                "tagStatus": "${try(each.value.tagStatus, "any")}",
                "countType": "imageCountMoreThan",
                "countNumber": ${try(each.value.count, 30)}
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

