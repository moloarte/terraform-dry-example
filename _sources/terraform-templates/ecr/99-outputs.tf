output "ecr" {
  value = {
  for key, value in aws_ecr_repository.ecr_repository :
  key => {
    name = value.name
    repository_url   = value.repository_url
    used_version_url = can(var.repos[key].used_version) ? format("%s:%s", value.repository_url, var.repos[key].used_version) : ""
  }
  }
}
