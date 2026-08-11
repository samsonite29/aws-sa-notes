# Cloud Security

## IAM - Identity Access Management

### Anatomy of an IAM policy

Given the below policy example

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowRootAccountGetPut",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::ACCOUNT_ID:root"
      },
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::BUCKET_NAME/*"
    }
  ]
}

```

Where principal = Account or user or role the policy would be applied to
Action = List of actions the policies allows or denies depending on the effect
Resource = Resources the policy applies to

### IAM Security Tools

1. IAM Credentials Report - Account level
This is a report that shows you a list of users and the status of their credentials in an account
2. IAM Access Advisor - User Level
The advisor shows the service permissions granted to a user and when those services were last accessed. The advisor can be useful when revision of policies takes places, Revision of policies includes(Making them compliant, Accurate and Effective in the context of security)

### IAM Best Practices

1. Do not use root accounts
2. One AWS user = one physical user
3. Enforce MFA
4. Create and Use Roles for giving permissions to AWS services
5. For auditing the IAM credentials use the credentials report and IAM access advisor
