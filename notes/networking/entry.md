# AWS Networking Services

## Connectivity

- **VPC (subnets)**: your private network in AWS, split into public and private subnets.
- **Internet Gateway**: lets a VPC talk to the internet, in both directions.
- **Egress-only Internet Gateway**: outbound-only internet for IPv6.
- **NAT Gateway**: lets private subnets reach the internet without being reachable from it.
- **Elastic IP / ENI**: a fixed public IP, and the network card attached to a resource.
- **VPC Peering**: a direct 1:1 link between two VPCs. Simple, but doesn't scale.
- **Transit Gateway**: a central hub connecting many VPCs and on-prem networks.
- **AWS Cloud WAN**: a managed global network across regions, run from one policy.
- **Site-to-Site VPN**: an encrypted tunnel from on-prem to AWS over the internet.
- **Client VPN**: lets individual users VPN into AWS.
- **Direct Connect**: a dedicated private line from your data centre to AWS.
- **PrivateLink / VPC Endpoints**: private access to AWS services or other VPCs without touching the internet.
- **VPC Lattice**: service-to-service connectivity across VPCs and accounts, with built-in auth.
- **VPC IPAM**: plans and tracks IP ranges so CIDRs don't clash.

## Network Security

- **Security Groups**: stateful firewall at the instance or ENI level, allow rules only.
- **Network ACLs**: stateless firewall at the subnet level, with allow and deny rules.
- **AWS WAF**: blocks bad HTTP requests (SQLi, XSS, bots) in front of ALB, CloudFront, or API Gateway.
- **AWS Shield**: DDoS protection. Standard is free; Advanced is paid and comes with a response team.
- **AWS Network Firewall**: managed firewall for deep packet inspection and domain filtering at the VPC level.
- **AWS Firewall Manager**: pushes WAF, security group, and firewall rules across all accounts centrally.
- **Route 53 Resolver DNS Firewall**: blocks DNS lookups to bad or unapproved domains.
- **Gateway Load Balancer**: routes traffic through third-party firewall or inspection appliances.
- **AWS Verified Access**: zero-trust access to internal apps without a VPN.
- **VPC Flow Logs**: records which IPs talked to which, and whether traffic was allowed.
- **Reachability / Network Access Analyzer**: checks whether a path is open, and finds paths that shouldn't be.

## Routing & Traffic Management

- **Route Tables**: decide where traffic leaves a subnet: IGW, NAT, TGW, peering, and so on.
- **Route 53**: DNS, plus routing policies like latency, geo, weighted, and failover with health checks.
- **Route 53 Resolver**: DNS between your VPCs and on-prem, in both directions.
- **Application Load Balancer**: Layer 7 load balancing. Routes on path, host, and headers.
- **Network Load Balancer**: Layer 4 load balancing. Very fast, with static IPs.
- **CloudFront**: CDN that caches content close to users.
- **Global Accelerator**: sends users onto AWS's backbone at the nearest edge, with fast regional failover.
- **API Gateway**: front door for APIs, handling routing, throttling, and auth.
- **AWS Cloud Map**: service discovery, so services can find each other by name.

## Services that span across multiple networking categories

- **Gateway Load Balancer**: a load balancer by design, but used almost entirely for security inspection.
- **VPC Lattice**: touches connectivity, routing, and security (auth policies).
- **PrivateLink**: connectivity, but chosen mainly for the security benefit of staying off the internet.
- **Flow Logs / Reachability Analyzer**: visibility tools, grouped under security because that's their main use.

### Core Difference Between AWS Load Balancers

1. ALB(Application Load Balancer) - Mainly dealing with HTTP and HTTPS traffic (Web requests) Application Layer on OSI
2. NLB(Network Load Balancer) - Mainly TCP, UDP and TLS traffic(Network Connection) - Transport Layer on OSI
3. GLB(Gateway Load Balancer) - Distributes Traffic to multiple virutal apliances(Firewall,  Intrusion Detection Software) for inspection before traffic continues to destination. GLB provides a centralised point for distributing traffic across multiple appliances

### Best Practices For Network Security

1. If you have an ALB in front of EC2 instances, instances should only accept inbound traffic from the ALB's security group.
   - SGs are stateful: responses back to the ALB are allowed automatically, so no instance egress rule is needed for them.
   - Restrict ALB egress to the instance SG on the app and health check ports.
   - Instance egress should allow only what the instance itself starts (DB, package repos, AWS APIs), not "ALB only".
   - NACLs are stateless: allow ephemeral ports (1024–65535) outbound to the ALB subnets.

### Sticky Sessions In Load Balancer

Sticky Session enables the load balancer to bind a user's session to a specific instance. This ensures that all requests from the user during the session are sent to the same instance.

### Cross Load Balancing

Cross load balancing is evenly distributing traffic across instances in all AZ. But when and why would I consider this approach.

#### Cross-zone load balancing — example

Setup: 1 load balancer, nodes in eu-west-1a and eu-west-1b.
10 instances in 1a, 10 instances in 1b.

5 instances in 1a go down → 5 in 1a, 10 in 1b (15 total).

**Cross-zone OFF:** each node only sends to its own AZ.

![alt text](image-2.png)

Each AZ still gets 50% of traffic.

- 1a: 50% ÷ 5  = 10% per instance (overloaded)
- 1b: 50% ÷ 10 = 5% per instance (underused)

**Cross-zone ON:** nodes send to all healthy targets in any AZ.

![alt text](image-1.png)

- 100% ÷ 15 = ~6.7% per instance, even load

Takeaway: cross-zone evens out load *per instance*, not per AZ.
Matters most when instance counts across AZs are uneven.

### SSL & TLS

![alt text](image.png)

1. SSL Ceritificate - Traffic between client and LB is encrypted in trasnit that is called inflight encryption. Traffic can only be decrypted by only the sender and the reciever.

2. SSL - Secure Sockets Layer is used to encrypt connections
3. TLS - Transport Layer Security, A newer version of TLS

#### SNI - Server Name Indication

**Problem** - How do I load multiple SSL certifcates onto one web server and server multiple websites. This solution only supports ALB and NLB.

![alt text](image-3.png)

With ALB and NLB multiple listeners can use multiple SSL certificates via SNI

### Connection Draining or De-registering Delay(ALB and NLB)

What this does is that it gives your instances time to complete active request while the instance is unhealthy or being de-registered

Also stops sending new requests to the EC2 instance which is being de-registered

### References

1. OSI Model - [https://www.infosectrain.com/blog/osi-model-a-comprehensive-guide-for-exam-and-interview]

### Terraform Networking Modules

Build top to bottom. Each layer reads outputs from the one above.

#### Layer 0: Org and shared network

Owned by the central network team. Rarely changes.

| Module | Covers |
|---|---|
| `ipam` | VPC IPAM pools, CIDR allocation |
| `transit-gateway` | TGW, route tables, RAM sharing |
| `cloud-wan` | Core network and policy (notes only for the exam) |
| `direct-connect` | DX gateway, virtual interfaces |
| `site-to-site-vpn` | Customer gateway, VPN connection |
| `firewall-manager` | Org-wide WAF, SG and firewall policies |
| `dns-resolver` | Resolver endpoints, forwarding rules, DNS Firewall |

#### Layer 1: VPC foundation

One per account or environment.

| Module | Covers |
|---|---|
| `vpc` | VPC, public/private subnets, IGW, egress-only IGW, route tables |
| `nat-gateway` | NAT plus Elastic IPs, one per AZ or single |
| `tgw-attachment` | Attaches the VPC to TGW and adds routes |
| `vpc-peering` | Peering connection and routes on both sides |
| `vpc-endpoints` | Gateway endpoints (S3, DynamoDB) and interface endpoints |
| `network-acls` | Subnet-level allow/deny rules |
| `flow-logs` | VPC Flow Logs to S3 or CloudWatch |

#### Layer 2: Security baseline

Per VPC. Owned by the security team.

| Module | Covers |
|---|---|
| `network-firewall` | Firewall, policy, rule groups, inspection routes |
| `gateway-load-balancer` | GWLB and endpoints for third-party appliances |
| `verified-access` | Zero-trust access to internal apps |
| `client-vpn` | Client VPN endpoint, auth, authorisation rules |
| `shield-advanced` | Protections and response team setup (paid, notes only) |

#### Layer 3: App and traffic

Owned by app teams. Changes often.

| Module | Covers |
|---|---|
| `security-group` | One reusable SG module, used by every app |
| `alb` | ALB, listeners, path and host rules, target groups |
| `nlb` | NLB with static IPs |
| `waf` | Web ACL and managed rules, attached to ALB, CloudFront or API GW |
| `route53-zone` | Public and private hosted zones |
| `route53-records` | Weighted, latency, geo, failover records and health checks |
| `cloudfront-distribution` | CDN with OAC to S3 |
| `global-accelerator` | Accelerator, listeners, endpoint groups |
| `api-gateway-rest` | API, stages, throttling, auth |
| `privatelink-service` | Endpoint service to expose your app to other VPCs |
| `vpc-lattice` | Service network, services, auth policies |
| `cloud-map` | Namespace and service discovery |

#### Not modules

- **Reachability Analyzer / Network Access Analyzer**: tools you run, not infrastructure.
- **ENI**: created by other resources, so no module of its own.


###  Exam priority: build in this order

1. `vpc`: VPC, public/private subnets across 2+ AZs, Internet Gateway, egress-only IGW, route tables
2. `nat-gateway`: NAT + Elastic IP, plus the private route to it
3. `security-group`: stateful, allow-only rules
4. `network-acls`: stateless, subnet-level allow/deny
5. `vpc-endpoints`: S3/DynamoDB gateway endpoints + one interface endpoint
6. `flow-logs`: send to S3 or CloudWatch, then test SG vs NACL blocks
7. `vpc-peering`: build a second VPC and peer them
8. `transit-gateway`: replace the peering with TGW and compare