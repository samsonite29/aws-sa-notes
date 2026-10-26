# AWS Database Services

## Storage vs Database

- **Storage** holds bytes. It doesn't understand the data.
- **Database** understands the data: structure, querying, indexes, transactions, and concurrency control. It runs on compute and saves its data to storage.

## Relational (SQL)

Tables with fixed columns, joined via keys. Strong consistency and transactions.

- **RDS**: managed Postgres, MySQL, MariaDB, Oracle, SQL Server, and Db2.
- **Aurora**: AWS's cloud-native MySQL/Postgres. Faster and more resilient than standard RDS.
- **Aurora DSQL**: distributed, serverless SQL across regions.

## Non-Relational (NoSQL)

Each type is built for a specific access pattern.

### Key-Value
Look up a value by its key. Extremely fast at huge scale, weak at complex queries.
- **DynamoDB**

### Document
JSON-like documents with a flexible schema.
- **DocumentDB**: MongoDB-compatible.

### In-Memory
Data held in RAM for microsecond reads. Often a cache in front of another database.
- **ElastiCache**: Valkey, Redis, Memcached.
- **MemoryDB**: durable in-memory database, Redis/Valkey-compatible.

### Graph
Nodes and relationships. Good for connection questions like fraud rings and recommendations.
- **Neptune**

### Wide-Column
Rows with flexible columns, spread across many nodes for very high write throughput.
- **Keyspaces**: Cassandra-compatible.

### Time-Series
Data points stamped with time, like metrics and IoT readings.
- **Timestream**

### Search
Full-text search and log analytics.
- **OpenSearch**

## Workload Type (cuts across all of the above)

- **OLTP (transactional)**: many small, fast reads and writes. "Place this order."
- **OLAP (analytical)**: big queries over huge datasets. "Total sales by region over 5 years."
  - **Redshift**: data warehouse.
  - **Athena**: SQL directly on files in S3.

## Notes

- **Vector search** isn't a separate database. It's a feature on existing ones: pgvector on RDS/Aurora, OpenSearch, and S3 Vectors.
- **QLDB** (ledger database) has been retired.