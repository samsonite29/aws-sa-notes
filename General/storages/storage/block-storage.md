# Storage General Knowlegde

## EBS Elastic Block Store

So think of this like a network flash drive that is attached to your instance while they run. Its a portable storage device that is connected over the network. They are used to persist data even after their termination. Very good for long term storage

They are bound/locked to a specific AZ and they are easily detachable. Root/ primary EBS are deleted by default whenever the associated instance are terminated but secondary are not deleted by default.

The whole purpose of EBS volumes is persist data even after the termination of Instances..

 ![Elastic Block Store](../../../general/diagrams/ebs.svg)

EBS volume most porpular

1. GP2 and GP3 SSD - General Purpose SSD that are cost effective and provides low latency 

## EC2 Instance Store

 Instance Store are disks(hard drives that are physicall bolted into a machine) physically attached to the host vms / computer. Instance store are ideal for temporary storage sych as buffers, caches etc. Very good for temporary storage and I/O performance.
