# Resource Variables
variable "acl" {
  description = "The canned ACL to apply. Valid values are private, public-read, public-read-write, aws-exec-read, authenticated-read, and log-delivery-write"
  type        = string
  validation {
    condition = contains([
      "private", "public-read", "public-read-write", "aws-exec-read", "authenticated-read", "log-delivery-write"
    ], var.acl)
    error_message = "ACL must be 'private', 'public-read' or 'public-read-write', 'aws-exec-read', 'authenticated-read', 'log-delivery-write'."
  }
  default = "private"
}

variable "bucket_name" {
  description = "Name of the bucket. Conflicts with `bucket_prefix`"
  type        = string
  default     = null
}

variable "bucket_prefix" {
  description = "Prefix of the bucket name. Conflicts with `bucket_name`"
  type        = string
  default     = null
}

variable "control_object_ownership" {
  description = "Whether to manage S3 Bucket Ownership Controls on this bucket."
  type        = bool
  default     = false
}

variable "kms_key_name" {
  description = "The AWS KMS master key name used for the SSE-KMS encryption"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error"
  type        = bool
  default     = false
}

variable "object_ownership" {
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL."
  type        = string
  default     = "ObjectWriter"
}

variable "versioning" {
  description = "Configuration map for the versioning options of the bucket. The `mfa` parameter needs to be passed like this `arn:aws:iam::<account-id>:mfa/root-account-mfa-device <mfacode>`"
  type        = object({
    enabled    = bool
    mfa_delete = optional(bool)
    mfa        = optional(string)
  })
  default = {
    enabled    = false
    mfa_delete = null
    mfa        = null
  }
}

variable "encryption" {
  description = "Configuration object for server side encryption parameters"
  type        = object({
    sse_algorithm      = optional(string)
    kms_key_name       = optional(string)
    bucket_key_enabled = optional(bool)
  })
  default = null
}

variable "lifecycle_rules" {
  description = "Map of configuration objects for one or multiple lifecycle rules. Do not create an empty object if you are not going to use rules."
  type        = any
  default     = {}
}

variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = false
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = false
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = false
}

variable "website" {
  description = "Map containing static web-site hosting or redirect configuration."
  type        = map(any)
  default     = {}
}
