
# AWS Network Architecture

## Why Elastic IPs Replect Poor Architectural Decisions

Everytime an EC2 starts and stops the public IP is change, why? There is a limited number of IPV4 addresses and AWS has to share this pools millions of accounts and instances. There is no point allowing an instance hold on to its public IP because at that moments its not being used. So when an instance is stopped, AWS reclaims the IP for another to use.

While elastic IP solves the above problems. Its more a solution that mask an underlying architectural issue. The architecural issues includes the following 

1. Single Point Of Failure - Elastic Ip has a 1 to 1 relationship with an instance. If the instance dies, you'd have to manually remap the EIP to a new instance instead of relying on availability technqiues such as load balancing or Auto Scaling

2. EIP does scale horizontally  - Because they are 1 to 1 and the EIP force traffic to only one instance, you cant have multiple instances behind a single EIP which forces vertical scaling

Solutions can be either to use load balancer or a random public IP mapped to a DNS name.