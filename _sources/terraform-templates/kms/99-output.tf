output "keys" {
  value = { for key, value in aws_kms_key.key :
    value.tags["Name"] => {
      arn   = value.arn
      id    = value.id
      alias = format("alias/%s", value.tags["Name"])
    }
  }
}