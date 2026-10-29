# AWS Storage Services

## Block Storage

The OS sees a disk. Raw blocks with a filesystem on top. Fast, low-latency, usually attached to one instance.

- **EBS (Elastic Block Store)**: persistent network-attached disks for EC2.
- **EC2 Instance Store**: temporary disks physically on the host. Very fast, but data is lost when the instance stops.

## File Storage

The OS sees a shared folder. Mounted by many machines at once over NFS or SMB.

- **EFS (Elastic File System)**: managed NFS for Linux. Grows and shrinks automatically.
- **FSx for Windows File Server**: managed SMB shares for Windows workloads.
- **FSx for Lustre**: high-performance filesystem for HPC and ML training.
- **FSx for NetApp ONTAP**: managed NetApp, supporting NFS, SMB, and iSCSI.
- **FSx for OpenZFS**: managed ZFS for Linux workloads.

## Object Storage

The app calls an API. Objects in buckets, addressed by key, accessed over HTTP.

- **S3**: virtually unlimited, very durable object storage.
- **S3 Glacier (Instant / Flexible / Deep Archive)**: archive tiers. Cheaper, with slower retrieval.

## Supporting Categories

Not storage types themselves. Jobs you do with storage.

### Backup & Recovery
- **AWS Backup**: central backup policies across EBS, EFS, RDS, DynamoDB, and more.
- **EBS Snapshots**: point-in-time copies of EBS volumes, stored in S3.

### Data Transfer & Migration
- **DataSync**: moves data between on-prem and AWS storage, or between AWS services.
- **Transfer Family**: managed SFTP/FTPS/FTP in front of S3 or EFS.
- **Snow Family**: physical devices for shipping large amounts of data to AWS.

### Hybrid
- **Storage Gateway**: presents AWS storage to on-prem as a file share, volume, or virtual tape.

## Quick Rule

- **Block**: the OS sees a disk.
- **File**: the OS sees a shared folder.
- **Object**: the app calls an API.