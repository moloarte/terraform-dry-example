data "aws_secretsmanager_secret_version" "secret" {
  secret_id = local.dependency.docker_secret.eks_secret_arn
}

resource "kubernetes_secret" "docker_auth" {
  count = var.docker_auth_enabled ? 1 : 0

  metadata {
    name      = "docker-auth"
    namespace = kubernetes_namespace.namespace.0.metadata[ 0 ].name

    annotations = merge(local.annotations, {
      "description" = "Docker-registry secret for ${var.name} namespace"
    }
    )
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = data.aws_secretsmanager_secret_version.secret.secret_string
  }
}
