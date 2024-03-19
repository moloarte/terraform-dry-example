{
  "Version": "2012-10-17",
  "Id": "kms-key-policy",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "Allow attachment of persistent resources",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"        ]
      },
      "Action": [
        "kms:CreateGrant"
      ],
      "Resource": "*",
      "Condition": {
        "Bool": {
          "kms:GrantIsForAWSResource": "true"
        }
      }
    },
    {
      "Sid": "Enable EC2 User Permissions",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${account_id}:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"        ]
      },
      "Action": [
        "kms:*",
        "kms:Decrypt",
        "kms:DescribeKey",
        "kms:Encrypt",
        "kms:Generate*",
        "kms:ReEncrypt*"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Enable Org account permissions",
      "Effect": "Allow",
      "Principal": "*",
      "Condition": {
        "ForAnyValue:StringEquals": {
          "aws:PrincipalOrgPaths": "o-r38eq7rak7/r-8tyy/ou-8tyy-cj1xsc67/ou-8tyy-64jox1mx/"
        }
      },
      "Action": [
        "kms:*",
        "kms:Decrypt",
        "kms:DescribeKey",
        "kms:Encrypt",
        "kms:Generate*",
        "kms:ReEncrypt*"
      ],
      "Resource": "*"
    }
  ]
}
