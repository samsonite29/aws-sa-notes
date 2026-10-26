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

## Services that straddle categories

- **Gateway Load Balancer**: a load balancer by design, but used almost entirely for security inspection.
- **VPC Lattice**: touches connectivity, routing, and security (auth policies).
- **PrivateLink**: connectivity, but chosen mainly for the security benefit of staying off the internet.
- **Flow Logs / Reachability Analyzer**: visibility tools, grouped under security because that's their main use.