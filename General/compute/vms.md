# Placement Groups

Placement groups enables users to influence how instances are placed on underlying hardware.

- Cluster Strategy Placement Group : Enables applications with tightly coulped node to node communication to achieve low lantency network performance by putting all the EC2 in a single AZ.
    Tradeoff - Users goal is low latency and high network througput and because of this goal the strategy isn't fault tolerant(Fault tolerance specifically refers to a system's capability to handle faults without any degradation or downtime.) With cluster strategy, you would have correllated failures meaning if the AZ fails,all systems go down.This strategy favors network performance over fault tolerance/availability.

    ![Cluster Placement Group](../../general/diagrams/pg-cluster.svg)

- Spread Placement Group: places critical instances on different racks/hardware, with the   goal of high availability and reducing the risk of correlated failures.
    Tradeoff — because the goal is fault isolation, you give up low latency. Instances aren't optimized to be physically close, so inter-instance communication isn't as fast as it would be in a Cluster group. This strategy favors fault tolerance/availability over network performance.

    ![Spread Placement Group](../../general/diagrams/pg-spread.svg)

- Partition Placement Group: divides a large group of instances into logical partitions, where no two partitions share the same underlying racks, with the goal of reducing correlated failures for large distributed, replicated workloads.
    Tradeoff — because the goal is fault isolation, you give up low latency. Instances aren't optimized to be physically close, so inter-instance communication isn't as fast as it would be in a Cluster group. This strategy favors fault tolerance/availability over network performance, but the isolation is weaker than Spread's since instances within the same partition can still share hardware.

    ![Partition Placement Group](../../general/diagrams/pg-partition.svg)

## PG Reference

1. <https://medium.com/pinterest-engineering/how-pinterest-runs-kafka-at-scale-ff9c6f735be>
2. <https://aws.amazon.com/blogs/compute/using-partition-placement-groups-for-large-distributed-and-replicated-workloads-in-amazon-ec2/>