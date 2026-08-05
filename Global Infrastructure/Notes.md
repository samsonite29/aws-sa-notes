# AWS Global Infrastructure

## Scenario A

Transcorp Limited wants to lunch a new service and they need help in determining a region where they can lunch their service.

Response - Choosing a region to deploy a service depends on the following factors?

1. Data governance and legal requirements: Different countries in certain regions have different rules and regulations on how data should be handled or distributed.
2. User Proximity - In order to have achieve low latency(Faster Response to requests), The service should be deployed in the region where you are likely to have a bulk of important users.
3. Service Availability - Not all AWS services are available in every region
4. Service Pricing - The pricing for AWS services differ region to region

## EC2 Instance Types

1. General Purpose Instance -  These instances have a good balance between Compute, Memory and Networking
2. Compute Optimized(C name) - Good for compute intensive tasks such as High performance computing(HPC), Batch Processing, Dedicated Gaming Servers, Machine learning
3. Memory Optimized(RAM, R name ) - processing large datasets in memory - Databases, Distributed Cache, In memory db, Real time processing of big unstructed data
4. Storage Optimized(I or D name) - Storage intensive task such as read and writing of large datasets on local storage - Cache, Data warehouse, OLTP, Distributed File Systems

Reference - https://ec2instances.github.io/