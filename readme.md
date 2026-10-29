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

| Section | What to build | Why |
|---|---|---|
| 8. ELB + ASG | `alb`, `asg` → `stateless-web-app` | Core exam topic, and it uses your `launch-template` |
| 9. RDS, Aurora, ElastiCache | `rds-instance` only | Multi-AZ vs read replica is easier to grasp once you've built it. Skip Aurora/ElastiCache code: slow to create and expensive |
| 10. Route 53 | `route53-records` (weighted, failover) | Networking. Failover with health checks is a great lab |
| 14. S3 Security | `s3-bucket` with bucket policy, encryption, block public access | Security. Covers what you need from 12 and 13 too |
| 15. CloudFront | `cloudfront-distribution` with OAC to S3 | Builds on 14. Notes only for Global Accelerator |
| 19. Serverless | `lambda-function`, `api-gateway-rest`, `dynamodb-table` | Biggest new area for the exam |
| 24. IAM | `iam-roles`, `iam-policy-boundaries` | Security. Policies are best learned by writing them |
| 25. AWS Security | `kms-key`, plus WAF on your ALB | Security. Notes for GuardDuty, Inspector, Macie, Shield |
| 26. Networking | `vpc-network`, `vpc-endpoints` | Your core interest, and the most exam-heavy section. Give it the most time |

#### Study Instructions

1. Watch the whole section. Take rough notes as you go. Do the console demos along with the video if you like, but no Terraform yet.
2. Draw the diagram. Do it from memory first, then check it against the slides. If you can’t draw it, rewatch that part before building.

3. Build it in Terraform. Write the modules and the stack, apply, test it works, then destroy.

4. Tidy the notes. Add anything you only understood while building, like the “aha, that’s why it needs a health check” moments.


### Notes and diagram only

| Section | Why no code |
|---|---|
| 11. Architecture Discussions | It walks through the stacks you'll build in 8–10 anyway. Diagram each one |
| 12. S3 basics | Fine to skip the video. 14 covers what you'd build |
| 13. Advanced S3 | Storage classes and lifecycle are memorise-and-compare. Add a lifecycle rule to `s3-bucket` if you want, it's 10 lines |
| 16. Storage Extras | Snow, FSx, Storage Gateway. Pick-the-right-service questions |
| 17. Decoupling | Notes only, but **don't skip it**. SQS vs SNS vs Kinesis comes up a lot in the exam |
| 18. Containers | You run EKS daily. Note the ECS/Fargate differences: launch types, task roles |
| 20. Databases | A comparison section. One table of "which DB for which use case" covers it |
| 21. Data & Analytics | Athena, Glue, Redshift, EMR. The exam only tests which one to pick |
| 22. Machine Learning | Same. Know what each service does in one line |
| 23. Monitoring | You covered CloudWatch/CloudTrail/Config in depth for SOA-C03. Skim and note what's new |
| 27. DR & Migrations | Diagram the four DR strategies. Note DMS and the migration services. The DR stacks can come after 1 Dec |

#### Study Instructions For Notes Section

1. Watch the whole section. Take rough notes as you go. Do the console demos along with the video if you like, but no Terraform yet.
2. Draw the diagram. Do it from memory first, then check it against the slides. If you can’t draw it, rewatch that part before building.


## Two things to watch

**That's 9 build sections in about 4.5 weeks.** That's more than one a week, so keep 9, 15 and 25 small: one module each, applied and destroyed in a single sitting. Put your weekend time into 8, 19 and 26.

**Build `vpc-network` early, even though it's section 26.** Sections 8, 9 and 19 all run better in a proper VPC with private subnets. Use the default VPC for section 8, then build `vpc-network` before 9, since RDS should go in private subnets. When you reach 26, you're extending a module you already have, not starting from scratch.