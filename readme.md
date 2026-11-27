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


## Practice Practice Practice

### Build (Terraform)

|Nice work on ELB + ASG and RDS. Here's everything in one table, in priority order:

| # | Section | What to build | Why | Status |
|---|---|---|---|---|
| – | 8. ELB + ASG | `alb`, `asg` → `stateless-web-app` | Core exam topic, and it uses your `launch-template` | ✅ Done |
| – | 9. RDS, Aurora, ElastiCache | `rds-instance` only | Building it makes Multi-AZ vs read replica clear. Skip Aurora and ElastiCache code, they're slow and expensive | ✅ Done |
| 1 | 26. Networking | `vpc-network`, `vpc-endpoints` | Everything else sits inside it, and it's the most exam-heavy | Next |
| 2 | 24. IAM | `iam-roles`, `iam-policy-boundaries` | Every platform decision touches access. Boundaries enable safe self-service | To do |
| 3 | 25. AWS Security | `kms-key`, plus WAF on your ALB | KMS keys get reused by S3, DynamoDB and Lambda later | To do |
| 4 | 14. S3 Security | `s3-bucket` with bucket policy, encryption, block public access | Reinforces your KMS key and IAM policies | To do |
| 5 | 10. Route 53 | `route53-records` (weighted, failover) | DNS and failover are core platform skills. Prepares you for multi-region questions | To do |
| 6 | 15. CloudFront | `cloudfront-distribution` with OAC to S3 | Builds on 14 and 10. Lower priority for platform work | To do |
| 7 | 19. Serverless | `lambda-function`, `api-gateway-rest`, `dynamodb-table` | Big exam area, less central to platform interviews. Do it last but leave time | To do |

#### Study Instructions

1. Watch the whole section. Take rough notes as you go. Do the console demos along with the video if you like, but no Terraform yet.
2. Draw the diagram. Do it from memory first, then check it against the slides. If you can’t draw it, rewatch that part before building.

3. Build it in Terraform. Write the modules and the stack, apply, test it works, then destroy.

4. Tidy the notes. Add anything you only understood while building, like the “aha, that’s why it needs a health check” moments.


### Notes and diagram only

| # | Section | Why no code |
|---|---|---|
| 1 | 17. Decoupling | Notes only, but **don't skip it**. SQS vs SNS vs Kinesis comes up a lot in the exam and in platform design questions |
| 2 | 27. DR & Migrations | Diagram the four DR strategies. Note DMS and the migration services. The DR stacks can come after 1 Dec |
| 3 | 11. Architecture Discussions | It walks through the stacks you build in 8–10. Diagram each one, which is great system design practice |
| 4 | 18. Containers | You run EKS daily. Note the ECS/Fargate differences: launch types, task roles |
| 5 | 20. Databases | A comparison section. One table of "which DB for which use case" covers it |
| 6 | 23. Monitoring | You covered CloudWatch/CloudTrail/Config in depth for SOA-C03. Skim and note what's new |
| 7 | 13. Advanced S3 | Storage classes and lifecycle are memorise-and-compare. Add a lifecycle rule to `s3-bucket` if you want, it's 10 lines |
| 8 | 16. Storage Extras | Snow, FSx, Storage Gateway. Pick-the-right-service questions |
| 9 | 21. Data & Analytics | Athena, Glue, Redshift, EMR. The exam only tests which one to pick |
| 10 | 12. S3 basics | Fine to skip the video. 14 covers what you'd build |
| 11 | 22. Machine Learning | Know what each service does in one line |

Decoupling, DR and architecture lead because they show up in both the exam and platform interviews. The bottom four are pure exam recall.

#### Study Instructions For Notes Section

1. Watch the whole section. Take rough notes as you go. Do the console demos along with the video if you like, but no Terraform yet.
2. Draw the diagram. Do it from memory first, then check it against the slides. If you can’t draw it, rewatch that part before building.

