This repository contains an export of the infrastructure used for the SCA CTF 2026 platform. It is provided as a reference for future improvements and research. All data related to personal information, including PII, has been removed.

This repository includes logs from the following projects:

- SMCTF Backend and Invite Bot [(nullforu/smctf)](https://github.com/nullforu/smctf)
- SMCTF Infrastructure v2 [(nullforu/smctf-infra-v2)](https://github.com/nullforu/smctf-infra-v2)
- Sandboxd-O [(swualabs/sandboxd-o)](https://github.com/swualabs/sandboxd-o)
- CloudTrail logs, CloudWatch Logs, and CloudWatch Metrics from the AWS account used to operate the platform (some data may not be included).

# PII Masking Rules

| Type                    | Description                                                                                                                      | Location                                             |                 Count | Sensitive example        | Masked example                           |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------- | --------------------: | ------------------------ | ---------------------------------------- |
| Email address           | Preserve the first/last local-part character and domain; add an ordinal suffix for collisions.                                   | JSON, JSONL, SQL dumps, compressed logs, TAR members | Determined at runtime | `<local>@<domain>`       | `u********r@<domain>`                    |
| User name / nickname    | Korean names retain first/last character; other display names retain first/last character. Collision suffixes are deterministic. | User records, Discord records, participant catalog   | Determined at runtime | `SampleUser`             | `S***r`                                  |
| Team name               | Use the display-name rule only for the participant-team catalog. Challenge and division names are retained.                      | `play_data.json` top-level `teams`                   | Determined at runtime | `SampleTeam`             | `S***m`                                  |
| Discord identifier      | Discord user IDs are replaced with a fixed redaction marker; Discord names use the display-name rule.                            | JSON, SQL dumps, logs, TAR members                   | Determined at runtime | `123456789012345678`     | `[REDACTED_ID]`                          |
| IP address              | Mask middle octets except explicitly retained VM/challenge external-address metadata.                                            | Logs, JSON, JSONL, TAR members                       | Determined at runtime | `<IPv4>`                 | `first.***.***.last`                     |
| OAuth / bearer token    | OAuth query parameters, bearer tokens, JWTs, and credential-like fields are replaced with a redaction marker.                    | URLs, headers, JSON, JSONL, logs                     | Determined at runtime | `code=value&state=value` | `code=[REDACTED]&state=[REDACTED]`       |
| AWS credentials         | AWS access key IDs and credential-like fields are replaced with a redaction marker.                                              | CloudTrail, inventory, logs, TAR members             | Determined at runtime | `AKIA...`                | `[REDACTED_AWS_ACCESS_KEY]`              |
| Phone / resident number | Redact only explicitly named structured fields. Bare digit sequences in telemetry are retained to prevent false positives.       | JSON and structured records                          | Determined at runtime | `phone: value`           | `phone: [REDACTED]`                      |
| Database password hash  | Replace database password hashes with one valid bcrypt hash so the example dump remains importable.                              | PostgreSQL SQL dump                                  |  One shared demo hash | bcrypt hash              | Valid bcrypt hash for `example-password` |

# File Tree

```
.
├── archive
│   ├── cloudtrail
│   │   ├── lookup-events-00-2026-04-20-2026-04-30.json
│   │   ├── lookup-events-01-2026-04-30-2026-05-10.json
│   │   ├── lookup-events-02-2026-05-10-2026-05-20.json
│   │   ├── lookup-events-03-2026-05-20-2026-05-30.json
│   │   ├── lookup-events-04-2026-05-30-2026-06-09.json
│   │   ├── lookup-events-05-2026-06-09-2026-06-19.json
│   │   ├── lookup-events-06-2026-06-19-2026-06-29.json
│   │   ├── lookup-events-07-2026-06-29-2026-07-09.json
│   │   ├── lookup-events-08-2026-07-09-2026-07-14.json
│   │   ├── lookup-events-08-2026-07-09-2026-07-19.json
│   │   └── lookup-events-summary.json
│   ├── cloudwatch-logs-api
│   │   ├── aws__ecs__containerinsights__sca-ctf-prod-backend__performance.jsonl.gz
│   │   ├── aws__ecs__sca-ctf-prod__backend.jsonl.gz
│   │   └── aws__ecs__sca-ctf-prod__invite-bot.jsonl.gz
│   ├── db
│   │   ├── app_db-20260719T094536Z.sql.gz
│   │   ├── rds-engine-logs
│   │   │   ├── error__postgres.log.log.gz
│   │   │   ├── error__postgresql.log.2026-07-17-11.log.gz
│   │   │   ├── error__postgresql.log.2026-07-17-12.log.gz
│   │   │   ├── error__postgresql.log.2026-07-17-13.log.gz
│   │   │   ├── error__postgresql.log.2026-07-17-14.log.gz
│   │   │   ├── error__postgresql.log.2026-07-17-15.log.gz
│   │   │   ├── error__postgresql.log.2026-07-17-16.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-01.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-02.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-03.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-04.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-05.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-06.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-07.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-08.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-09.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-10.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-11.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-12.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-13.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-14.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-15.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-16.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-17.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-18.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-19.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-20.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-21.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-22.log.gz
│   │   │   ├── error__postgresql.log.2026-07-18-23.log.gz
│   │   │   ├── error__postgresql.log.2026-07-19-00.log.gz
│   │   │   ├── error__postgresql.log.2026-07-19-01.log.gz
│   │   │   ├── error__postgresql.log.2026-07-19-02.log.gz
│   │   │   ├── error__postgresql.log.2026-07-19-03.log.gz
│   │   │   ├── error__postgresql.log.2026-07-19-04.log.gz
│   │   │   ├── error__postgresql.log.2026-07-19-05.log.gz
│   │   │   ├── error__postgresql.log.2026-07-19-06.log.gz
│   │   │   ├── error__postgresql.log.2026-07-19-07.log.gz
│   │   │   ├── error__postgresql.log.2026-07-19-08.log.gz
│   │   │   └── error__postgresql.log.2026-07-19-09.log.gz
│   │   └── rds-engine-logs-index.json
│   ├── inventory
│   │   ├── cloudtrail-describe-trails.json
│   │   ├── cloudwatch-describe-alarms.json
│   │   ├── ec2-describe-flow-logs.json
│   │   ├── ec2-describe-instances.json
│   │   ├── ec2-describe-nat-gateways.json
│   │   ├── ec2-describe-route-tables.json
│   │   ├── ec2-describe-security-groups.json
│   │   ├── ec2-describe-subnets.json
│   │   ├── ec2-describe-vpc-endpoints.json
│   │   ├── ec2-describe-vpcs.json
│   │   ├── ecs-describe-clusters.json
│   │   ├── ecs-list-clusters.json
│   │   ├── ecs-list-services.json
│   │   ├── elasticache-describe-cache-clusters.json
│   │   ├── elasticache-describe-replication-groups.json
│   │   ├── elbv2-describe-listeners.json
│   │   ├── elbv2-describe-load-balancer-attributes.json
│   │   ├── elbv2-describe-load-balancers.json
│   │   ├── elbv2-describe-target-groups.json
│   │   ├── logs-describe-log-groups.json
│   │   ├── rds-describe-db-instances.json
│   │   ├── rds-describe-db-log-files.json
│   │   ├── rds-describe-db-snapshots.json
│   │   └── sts-get-caller-identity.json
│   ├── metrics
│   │   ├── alb
│   │   │   ├── _list_metrics.json
│   │   │   ├── ActiveConnectionCount.json
│   │   │   ├── AnomalousHostCount.json
│   │   │   ├── ClientTLSNegotiationErrorCount.json
│   │   │   ├── ConsumedLCUs.json
│   │   │   ├── DesyncMitigationMode_NonCompliant_Request_Count.json
│   │   │   ├── HealthyHostCount.json
│   │   │   ├── HealthyStateDNS.json
│   │   │   ├── HealthyStateRouting.json
│   │   │   ├── HTTP_Redirect_Count.json
│   │   │   ├── HTTPCode_ELB_3XX_Count.json
│   │   │   ├── HTTPCode_ELB_4XX_Count.json
│   │   │   ├── HTTPCode_ELB_504_Count.json
│   │   │   ├── HTTPCode_ELB_5XX_Count.json
│   │   │   ├── HTTPCode_Target_2XX_Count.json
│   │   │   ├── HTTPCode_Target_3XX_Count.json
│   │   │   ├── HTTPCode_Target_4XX_Count.json
│   │   │   ├── HTTPCode_Target_5XX_Count.json
│   │   │   ├── MitigatedHostCount.json
│   │   │   ├── NewConnectionCount.json
│   │   │   ├── PeakLCUs.json
│   │   │   ├── ProcessedBytes.json
│   │   │   ├── RequestCount.json
│   │   │   ├── RequestCountPerTarget.json
│   │   │   ├── TargetResponseTime.json
│   │   │   ├── UnHealthyHostCount.json
│   │   │   ├── UnhealthyRoutingRequestCount.json
│   │   │   ├── UnhealthyStateDNS.json
│   │   │   └── UnhealthyStateRouting.json
│   │   ├── containerinsights-backend
│   │   │   ├── _list_metrics.json
│   │   │   ├── CpuReserved.json
│   │   │   ├── CpuUtilized.json
│   │   │   ├── DeploymentCount.json
│   │   │   ├── DesiredTaskCount.json
│   │   │   ├── EphemeralStorageReserved.json
│   │   │   ├── EphemeralStorageUtilized.json
│   │   │   ├── MemoryReserved.json
│   │   │   ├── MemoryUtilized.json
│   │   │   ├── NetworkRxBytes.json
│   │   │   ├── NetworkTxBytes.json
│   │   │   ├── PendingTaskCount.json
│   │   │   ├── RunningTaskCount.json
│   │   │   ├── StorageReadBytes.json
│   │   │   ├── StorageWriteBytes.json
│   │   │   └── TaskSetCount.json
│   │   ├── containerinsights-cluster
│   │   │   ├── _list_metrics.json
│   │   │   ├── ContainerInstanceCount.json
│   │   │   ├── CpuReserved.json
│   │   │   ├── CpuUtilized.json
│   │   │   ├── DeploymentCount.json
│   │   │   ├── DesiredTaskCount.json
│   │   │   ├── EphemeralStorageReserved.json
│   │   │   ├── EphemeralStorageUtilized.json
│   │   │   ├── MemoryReserved.json
│   │   │   ├── MemoryUtilized.json
│   │   │   ├── NetworkRxBytes.json
│   │   │   ├── NetworkTxBytes.json
│   │   │   ├── PendingTaskCount.json
│   │   │   ├── RunningTaskCount.json
│   │   │   ├── ServiceCount.json
│   │   │   ├── StorageReadBytes.json
│   │   │   ├── StorageWriteBytes.json
│   │   │   ├── TaskCount.json
│   │   │   └── TaskSetCount.json
│   │   ├── containerinsights-invite-bot
│   │   │   ├── _list_metrics.json
│   │   │   ├── CpuReserved.json
│   │   │   ├── CpuUtilized.json
│   │   │   ├── DeploymentCount.json
│   │   │   ├── DesiredTaskCount.json
│   │   │   ├── EphemeralStorageReserved.json
│   │   │   ├── EphemeralStorageUtilized.json
│   │   │   ├── MemoryReserved.json
│   │   │   ├── MemoryUtilized.json
│   │   │   ├── NetworkRxBytes.json
│   │   │   ├── NetworkTxBytes.json
│   │   │   ├── PendingTaskCount.json
│   │   │   ├── RunningTaskCount.json
│   │   │   ├── StorageReadBytes.json
│   │   │   ├── StorageWriteBytes.json
│   │   │   └── TaskSetCount.json
│   │   ├── ec2-bastion
│   │   │   ├── _list_metrics.json
│   │   │   ├── CPUCreditBalance.json
│   │   │   ├── CPUCreditUsage.json
│   │   │   ├── CPUSurplusCreditBalance.json
│   │   │   ├── CPUSurplusCreditsCharged.json
│   │   │   ├── CPUUtilization.json
│   │   │   ├── EBSByteBalance_.json
│   │   │   ├── EBSIOBalance_.json
│   │   │   ├── EBSReadBytes.json
│   │   │   ├── EBSReadOps.json
│   │   │   ├── EBSWriteBytes.json
│   │   │   ├── EBSWriteOps.json
│   │   │   ├── InstanceEBSIOPSExceededCheck.json
│   │   │   ├── InstanceEBSThroughputExceededCheck.json
│   │   │   ├── MetadataNoToken.json
│   │   │   ├── NetworkIn.json
│   │   │   ├── NetworkOut.json
│   │   │   ├── NetworkPacketsIn.json
│   │   │   ├── NetworkPacketsOut.json
│   │   │   ├── StatusCheckFailed_AttachedEBS.json
│   │   │   ├── StatusCheckFailed_Instance.json
│   │   │   ├── StatusCheckFailed_System.json
│   │   │   └── StatusCheckFailed.json
│   │   ├── ecs-cluster
│   │   │   ├── _list_metrics.json
│   │   │   ├── CPUUtilization.json
│   │   │   ├── LiveTaskCount.json
│   │   │   └── MemoryUtilization.json
│   │   ├── ecs-service-backend
│   │   │   ├── _list_metrics.json
│   │   │   ├── CPUUtilization.json
│   │   │   ├── LiveTaskCount.json
│   │   │   └── MemoryUtilization.json
│   │   ├── ecs-service-invite-bot
│   │   │   ├── _list_metrics.json
│   │   │   ├── CPUUtilization.json
│   │   │   ├── LiveTaskCount.json
│   │   │   └── MemoryUtilization.json
│   │   ├── elasticache-repl
│   │   │   ├── _list_metrics.json
│   │   │   ├── DatabaseCapacityUsageCountedForEvictPercentage.json
│   │   │   └── DatabaseMemoryUsageCountedForEvictPercentage.json
│   │   ├── natgateway
│   │   │   ├── _list_metrics.json
│   │   │   ├── ActiveConnectionCount.json
│   │   │   ├── BytesInFromDestination.json
│   │   │   ├── BytesInFromSource.json
│   │   │   ├── BytesOutToDestination.json
│   │   │   ├── BytesOutToSource.json
│   │   │   ├── ConnectionAttemptCount.json
│   │   │   ├── ConnectionEstablishedCount.json
│   │   │   ├── ErrorPortAllocation.json
│   │   │   ├── IdleTimeoutCount.json
│   │   │   ├── PacketsDropCount.json
│   │   │   ├── PacketsInFromDestination.json
│   │   │   ├── PacketsInFromSource.json
│   │   │   ├── PacketsOutToDestination.json
│   │   │   ├── PacketsOutToSource.json
│   │   │   ├── PeakBytesPerSecond.json
│   │   │   └── PeakPacketsPerSecond.json
│   │   ├── rds
│   │   │   ├── _list_metrics.json
│   │   │   ├── BurstBalance.json
│   │   │   ├── CheckpointLag.json
│   │   │   ├── CPUCreditBalance.json
│   │   │   ├── CPUCreditUsage.json
│   │   │   ├── CPUSurplusCreditBalance.json
│   │   │   ├── CPUSurplusCreditsCharged.json
│   │   │   ├── CPUUtilization.json
│   │   │   ├── DatabaseConnections.json
│   │   │   ├── DiskQueueDepth.json
│   │   │   ├── EBSByteBalance_.json
│   │   │   ├── EBSIOBalance_.json
│   │   │   ├── FreeableMemory.json
│   │   │   ├── FreeStorageSpace.json
│   │   │   ├── MaximumUsedTransactionIDs.json
│   │   │   ├── NetworkReceiveThroughput.json
│   │   │   ├── NetworkTransmitThroughput.json
│   │   │   ├── OldestLogicalReplicationSlotLag.json
│   │   │   ├── OldestReplicationSlotLag.json
│   │   │   ├── ReadIOPS.json
│   │   │   ├── ReadLatency.json
│   │   │   ├── ReadThroughput.json
│   │   │   ├── ReplicationSlotDiskUsage.json
│   │   │   ├── SwapUsage.json
│   │   │   ├── TransactionLogsDiskUsage.json
│   │   │   ├── TransactionLogsGeneration.json
│   │   │   ├── WriteIOPS.json
│   │   │   ├── WriteLatency.json
│   │   │   └── WriteThroughput.json
│   │   └── summary.json
│   └── notes
│       ├── bucket_name.txt
│       ├── collected_at_utc.txt
│       ├── collection-summary.json
│       └── collection-summary.txt
├── cloudwatch
│   └── on
│       ├── aws-logs-write-test
│       └── b6843ed9-5c4f-40c3-a430-1ae01efc4bf9
│           ├── backend-backend-0db2622f3d934f59b5cd1d38d0473ef0
│           │   └── 000000.gz
│           ├── backend-backend-216a9173a1e147caac0cbffc425721f7
│           │   └── 000000.gz
│           ├── backend-backend-2baa8f1cd6884bf783a2f30e22733d6a
│           │   └── 000000.gz
│           ├── backend-backend-2be48b50499a46119f256a8485e7b145
│           │   └── 000000.gz
│           ├── backend-backend-42662a50aa7942eea4d6032ac5ac020c
│           │   └── 000000.gz
│           ├── backend-backend-5368b49e27244211a9d912aa837ee65f
│           │   └── 000000.gz
│           ├── backend-backend-54d41028d4494559b52398de75afbe6c
│           │   └── 000000.gz
│           ├── backend-backend-706edc409ed044e69db8655b473dffdc
│           │   └── 000000.gz
│           ├── backend-backend-7f2f455ec22a43b0b461900d7e8c4b51
│           │   └── 000000.gz
│           ├── backend-backend-9487b8a036ff47beafc47752043a08c0
│           │   └── 000000.gz
│           ├── backend-backend-a728258e55b743ca908eba8743e1c08f
│           │   └── 000000.gz
│           ├── backend-backend-a8151f41333a49d7b8d2e42720234e8b
│           │   └── 000000.gz
│           ├── backend-backend-a93eb5d1363441bea52ab600755d7f33
│           │   └── 000000.gz
│           ├── backend-backend-ba07961c0eed46b9946839281dc8fd6d
│           │   └── 000000.gz
│           ├── backend-backend-c148889817ad4b539f5c14bf96782924
│           │   └── 000000.gz
│           ├── backend-backend-c3f8381095e346f798cbfac37ba91d73
│           │   └── 000000.gz
│           ├── backend-backend-d46c3e5ceb89435aa6b8731815ccd845
│           │   └── 000000.gz
│           ├── backend-backend-eba0d328fd454d65b12718dfebb3ce8b
│           │   └── 000000.gz
│           └── backend-backend-f6ee628b547e47ae88f758cc8aa73dbe
│               └── 000000.gz
├── play_data.json
├── sandboxd-o-logs
│   └── smctf-cluster
│       ├── 20260719T090856Z
│       │   ├── ip-10-0-2-194-i-05960d374e7e743c9.tar.gz
│       │   └── ip-10-0-30-2-i-050749b282c0088b8.tar.gz
│       ├── 20260719T091102Z
│       │   └── ip-10-0-1-253-i-0325180209aa56549.tar.gz
│       ├── control-plane-state
│       │   └── smctf-cluster-control-plane-state-20260719T090933Z.tar.gz
│       └── manifest
│           └── smctf-cluster-log-collection-manifest-20260719T091143Z.txt
└── sanitize_pii.py
```
