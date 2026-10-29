
# Storage Resiliency

## EBS Snapshot(Backup)

Snapshots are point-in-time copies that serves as backed up data. Snapshot are incremental backups which means only blocks on the volume that have changed since the most recent snapshot, This is to prevent data duplication. Snapshots can be copied across region and azs. Very very useful in DR, copy data to another region

 ![EBS Snapshot](../../../notes/diagrams/ebs-snapshot.svg)