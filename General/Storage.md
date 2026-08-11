# Storage General Knowlegde

## EBS Elastic Block Store

So think of this like a virtual hard drive(Like a USB Stick) that is attached to your instance while they run. They are used to persist data even after their terminication.

They are bound/locked to a specific AZ and they are easily detachable. Root/ primary EBS are deleted by default whenever the associated instance are terminated but secondary are not deleted by default

 ![Elastic Block Store](../General/diagrams/ebs.svg)
