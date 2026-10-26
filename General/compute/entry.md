# AWS Compute Services

Categorised by what you hand AWS. The further down the list, the less you manage, and the less control you have.

## VM: you hand AWS a server spec

You manage the OS and everything above it: patching, runtime, and scaling setup.

- **EC2**: virtual servers. Includes bare-metal, GPU, and other specialised instance types.
- **Lightsail**: simplified, fixed-price VMs for small workloads.
- **EC2 Auto Scaling**: adds and removes instances based on load.
- **EC2 Image Builder**: builds and patches AMIs (machine images).

## Container: you hand AWS an image

You package the app. A platform schedules and runs it.

### Orchestration (decides where containers run)
- **ECS**: AWS's own container orchestrator.
- **EKS**: managed Kubernetes.

### Capacity (what containers run on)
- **EC2 nodes**: you manage the instances.
- **Fargate**: serverless capacity, with no nodes to manage.

### Registry
- **ECR**: stores and scans container images.

## Function: you hand AWS a code snippet

AWS runs it on each event. No servers or containers to think about. Billed per invocation and duration, with run-time limits.

- **Lambda**: event-driven serverless functions.

## PaaS: you hand AWS an app

AWS handles the load balancer, scaling, and deployment.

- **Elastic Beanstalk**: deploys code onto managed EC2 with load balancing and scaling set up for you.
- **App Runner**: runs a web app or API from source code or a container image.

## Batch: you hand AWS a job

AWS queues the work and finds capacity. For large, non-interactive workloads.

- **AWS Batch**: managed job queues and scheduling on EC2 or Fargate.
- **ParallelCluster**: HPC clusters for tightly coupled workloads.

## Notes

### Hybrid & Edge (runs the categories above outside AWS regions)
- **Outposts**: AWS racks in your own data centre.
- **Local Zones**: AWS compute close to specific cities.
- **Wavelength**: AWS compute inside 5G telecom networks.
- **ECS / EKS Anywhere**: run AWS container orchestration on your own hardware.

### Built on compute, but their own categories
- **Databases**: RDS, DynamoDB, and so on.
- **AI/ML**: SageMaker, Bedrock.