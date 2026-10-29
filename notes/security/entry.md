# AWS Security Services

Categorised using the Security pillar of the AWS Well-Architected Framework.

## Identity & Access Management: who can do what

- **IAM**: users, roles, and policies controlling access to AWS resources.
- **IAM Identity Center**: single sign-on across AWS accounts and apps.
- **STS**: issues temporary credentials for roles.
- **Organizations SCPs**: account-wide limits on what permissions can be granted.
- **Cognito**: sign-up and sign-in for your app's end users.
- **Verified Permissions**: fine-grained authorisation for your own apps, using Cedar policies.
- **IAM Access Analyzer**: finds resources shared outside your account and unused permissions.

## Detection: seeing threats and misconfigurations

- **GuardDuty**: threat detection from CloudTrail, VPC Flow Logs, DNS logs, and more.
- **Security Hub**: central dashboard collecting findings from all security services.
- **Inspector**: scans EC2, containers, and Lambda for vulnerabilities.
- **CloudTrail**: logs every API call. Who did what, and when.
- **Config**: records resource configuration and changes over time.
- **Security Lake**: central data lake for security logs.

## Infrastructure Protection: hardening networks and hosts

### Network
- **Security Groups**: stateful firewall at the instance or ENI level.
- **Network ACLs**: stateless firewall at the subnet level.
- **AWS WAF**: blocks bad HTTP requests in front of ALB, CloudFront, or API Gateway.
- **AWS Shield**: DDoS protection.
- **AWS Network Firewall**: deep packet inspection and domain filtering at the VPC level.
- **AWS Firewall Manager**: central firewall rules across accounts.

### Host
- **Systems Manager Patch Manager**: automated OS patching.

## Data Protection: encryption, keys, and secrets

- **KMS**: managed encryption keys used across most AWS services.
- **CloudHSM**: dedicated hardware security modules for full key control.
- **Secrets Manager**: stores and rotates passwords, API keys, and database credentials.
- **ACM (Certificate Manager)**: issues and renews TLS certificates.
- **Private CA**: runs your own private certificate authority.
- **Macie**: finds sensitive data (PII) in S3.

## Incident Response: what happens once something is detected

- **Security Incident Response**: AWS-assisted triage and response for security events.
- **Detective**: investigates findings by linking related activity.
- **Systems Manager Incident Manager**: incident runbooks, escalation, and on-call.
- **EventBridge + Lambda**: automated response, e.g. isolating an instance when GuardDuty fires.

## Governance & Compliance: guardrails and proof

- **Organizations**: multi-account structure and policies.
- **Control Tower**: sets up a governed multi-account landing zone with guardrails.
- **Config Rules**: checks resources against required settings.
- **Audit Manager**: collects evidence for audits (SOC 2, ISO, PCI, and so on).
- **Artifact**: download AWS's own compliance reports.

## Quick Rule (as a lifecycle)

- **Identity**: who are you, and what are you allowed to do
- **Infrastructure & data protection**: lock things down
- **Detection**: notice when something's wrong
- **Incident response**: deal with it
- **Governance**: prove it and keep everyone on the rails

## Note

Network security is one slice of security as a whole: it sits under Infrastructure Protection.