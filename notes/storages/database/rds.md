# RDS

RDS supports postgre, mysql, mariadb, oracle, sql server, IBM DB2 and aurora.

## DREC Organisation

fantasy company for this section is DREC a multinational fintech organization. DREC operations across 2 different regions, namely eu-west-1(IRELAND) eu-west-2(LONDON). DREC has two main features - Credit Score Tracking and Loans.

1. DREC DATABASE ISSUE

a. Problem - Bulk updates on the primary slow down reads. Read and Write contest for resources.

Our primary database is a db.r6g.xlarge. As a rough example, 1k reads/sec + 1k writes/sec
uses about 45% CPU (reads ≈ 35% per 1k, writes ≈ 10% per 1k).
We want to stay under 70% to keep a buffer.

At peak, our services send 2k reads/sec (≈70% CPU) and 2k writes/sec (≈20% CPU).
That's about 90% CPU, well over our 70% limit.

b. Solution

So we added 2 read replicas and moved most reads to them:

- The primary keeps writes + ~200 reads/sec that need the latest data → 20% + 7% ≈ 27% CPU
- Each replica takes ~900 reads/sec (≈32%) plus ~20% for replaying writes → ~52% CPU

## Why should I use RDS when I have EC2

1. Read Replica for performance
2. Automactic Scalibility Capability - In & Out
3. Automated Provision and OS Patching
4. Continous Backups and restore to specific timestamp
5. Monitoring Dashboards
6. Multi AZ setup for DR activity
7. storage backedup by EBS

## Read Replicas & Multi AZ

**Read Replicas & Asynchronous Replications***

With AWS

1. we can have 15 replicas that can be used within AZ, cross AZ or cross region.

2. Replication Technique for DREC database is Asynchronous which means

    - loan microservice persites data to the main db, db tells microservices persist is done successfully. After a few miliseconds primary database then sends data to the replication but it doesn't wait for replication to tell it if has recieved the data or not. Async replication is the standard choice for **cross-Region disaster recovery**, since sync replication is too slow over long distances. It can also improve day-to-day performance by offloading reads and analytics from the primary.
    - Pair it with cross-Region backups (snapshots / AWS Backup), because replication copies deletes and corruption too
    - Expect some data loss on failover (RPO = replication lag)
    - Only helps read performance; writes still go to the primary
3. Microservices must update connection string to connect with read replicas

### Use case

![alt text](image.png)

### Replication Cost

![alt text](image-1.png)

### MultiAZ and DR

Standby Instance becomes main instance in DR. But why does Multi AZ use synchronous replication? Multi-AZ = sync because it’s about availability without data loss. Read replicas = async because they’re about performance and distance.

![alt text](image-2.png)

### How to move from a single AZ to a multi AZ

![alt text](image-3.png)

## Reference

1. [https://www.youtube.com/watch?v=mBUCF1WGI_I]
2. [https://aws.amazon.com/what-is/data-replication/]
3. [https://aws.amazon.com/blogs/database/amazon-rds-under-the-hood-multi-az/]
4. [https://homepages.cwi.nl/~boncz/lsde/papers/aurora.pdf]