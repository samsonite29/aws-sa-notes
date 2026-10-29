
# AWS Network Architecture

## Why Elastic IPs Replect Poor Architectural Decisions

Everytime an EC2 starts and stops the public IP is changed, why? There is a limited number of IPV4 addresses and AWS has to share the pool of IPV4 addresses with millions of accounts and instances. There is no point allowing an instance hold on to its public IP because at that moments its not being used. So when an instance is stopped, AWS reclaims the IP for another to use.

While elastic IP solves the above problems. Its more a solution that mask an underlying architectural issue. The architecural issues includes the following

1. Single Point Of Failure - Elastic Ip has a 1 to 1 relationship with an instance. If the instance dies, you'd have to manually remap the EIP to a new instance instead of relying on availability technqiues such as load balancing or Auto Scaling

2. EIP does scale horizontally  - Because they are 1 to 1 and the EIP force traffic to only one instance, you cant have multiple instances behind a single EIP which forces vertical scaling

Solutions can be either to use load balancer or a random public IP mapped to a DNS name.


## Elastic Network Interface

A physical network card connects computers or servers to a network. A network card facilitates(Makes an action or a process smoother and more likely to happen) communication between a computer/server and a local area network (LAN), wide area network (WAN), or the internet. It serves as an interface that allows the computer/server to connect to a network's physical medium such as copper wire, fiber optic, or wireless transmission. They operate the layer 3 and layer 2 of the OSI model  for the infrastructure they are attached to.

A virtual network card is a software based emulation of a physical network card. ENI represent a virtual network card. They are bound to a specific AZ

 ![Elastic Network Interface](../../../notes/diagrams/eni.svg)

### ENI Reference

1. <https://www.fs.com/uk/blog/what-is-a-network-interface-card-nic-definition-function-types-526.html>
2. ENI deep dive - https://aws.amazon.com/blogs/aws/new-elastic-network-interfaces-in-the-virtual-private-cloud/

## Terminologies

1. Correlated Failures - Systems fail together because of an underlying cause
2. Cascading Failures - Failure of a single component, causes the failure of other components
