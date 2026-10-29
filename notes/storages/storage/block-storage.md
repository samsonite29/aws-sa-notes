# Storage Notes

## EBS Elastic Block Store

So think of this like a network flash drive that is attached to your instance while they run. Its a portable storage device that is connected over the network. They are used to persist data even after their termination. Very good for long term storage

They are bound/locked to a specific AZ and they are easily detachable. Root/ primary EBS are deleted by default whenever the associated instance are terminated but secondary are not deleted by default.

The whole purpose of EBS volumes is persist data even after the termination of Instances..

 ![Elastic Block Store](../../../notes/diagrams/ebs.svg)

EBS volume most popular

1. GP2 and GP3 SSD - notes Purpose SSD that are cost effective and provides low latency
2. What are the difference types of EBS volume types and when do you use a particular one?

## EC2 Instance Store AKA High Performance Hardware Volumen for EC2s

 1. Instance Store are disks(hard drives that are physicall bolted into a machine) physically attached to the host vms / computer.
 2. Instance store are ideal for temporary storage such as buffers, caches etc.
 3. Very good for temporary storage and I/O performance.
 4. Instance Store are ephemeral(Zero Durability)
