{
  "Version": "2012-10-17",
  "Id": "RequireEncryption",
   "Statement": [
    {
      "Sid": "EnforcedTLS",
      "Effect": "Deny",
      "Action": "s3:*",
      "Resource": [
        "${s3_bucket_arn}",
        "${s3_bucket_arn}/*"
      ],
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      },
      "Principal": "*"
    },
    {
      "Sid": "RequireEncryptedStorage",
      "Effect": "Deny",
      "Action": ["s3:PutObject"],
      "Resource": [
            "${s3_bucket_arn}",
            "${s3_bucket_arn}/*"
        ],
      "Condition": {
        "ForAnyValue:StringNotEquals": {
          "s3:x-amz-server-side-encryption": [
            "aws:kms",
            "AES256"
          ]
        }
      },
      "Principal": "*"
    },
    {
      "Sid": "RootAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${account_id}:root"
        },
      "Action": "s3:*",
      "Resource": [
        "${s3_bucket_arn}",
        "${s3_bucket_arn}/*"
      ]
    }
  ]
}