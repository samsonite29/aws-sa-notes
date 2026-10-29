# aws-solutions-architect-labs - Deadline is 1st of december

## `modules/`: reusable building blocks

### Foundation

- `vpc-network`: VPC, subnets, IGW, NAT, route tables
- `vpc-endpoints`: gateway and interface endpoints
- `security-groups`
- `iam-roles`: roles, instance profiles, policy attachments

### Compute and scaling

- `ec2-instance`
- `launch-template`
- `alb`
- `nlb`
- `asg`: ASG plus scaling policies
- `route53-records`: simple, weighted, failover, latency

### Databases

- `rds-instance`: Multi-AZ and read replicas as flags
- `aurora-cluster`
- `elasticache-redis`
- `dynamodb-table`: streams, global tables as flags

### Storage and delivery

- `s3-bucket`: versioning, lifecycle, encryption, replication
- `cloudfront-distribution`
- `efs-filesystem`

### Serverless

- `lambda-function`
- `api-gateway-rest`
- `cognito-user-pool`
- `sqs-queue`
- `sns-topic`

### Security

- `kms-key`
- `ssm-parameters`
- `secrets-manager-secret`
- `iam-policy-boundaries`: permission boundaries, SCP examples

### Observability

- `cloudwatch-alarms`
- `cloudtrail-trail`

## `stacks/`: the solution architectures

- `stateless-web-app`: ALB + ASG + Route 53
- `stateful-web-app`: adds ElastiCache sessions and RDS
- `wordpress-efs`: ASG + EFS + Aurora
- `serverless-todo-app`: API Gateway + Lambda + DynamoDB + Cognito
- `serverless-website`: S3 + CloudFront + Lambda
- `micro-services-sqs-sns`: fan-out pattern
- `s3-event-pipeline`: S3 → Lambda/SQS
- `blue-green-deploy`: weighted Route 53 or ALB
- `dr-pilot-light`
- `dr-warm-standby`
- `dr-multi-site`
- `secure-baseline`: KMS, SSM, CloudTrail, IAM

## Two calls to make early

1. **DR stacks need two providers** (primary and DR region). Settle the provider-alias pattern before writing the first module, or you'll end up refactoring every one.
2. **Flags vs separate modules.** For things like `rds-instance` vs `aurora-cluster`, keep them separate. They differ enough under the hood that one module with flags gets messy fast. For smaller variants, like RDS read replicas, flags are fine.