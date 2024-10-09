# Project GetSchwifty

## Project Overview

---
## Environment Setup
- **IDE/Code Editor**: 
  - VSCode
- **Version Control**: 
  - Git
- **Dependencies**: 
---


## DockerHublink: 
https://hub.docker.com/repository/docker/beowulfgang/getschwifty
## Buildtime:	
- 61.1s

## What can I do to improve:	
- I'd cache the build either in S3 storage or some form of caching. I could also change the build image to something slimmer. 

## Scanned Report:	
=======================================
Total: 3 (HIGH: 3, CRITICAL: 0)
┌────────────────┬────────────────┬──────────┬──────────┬───────────────────┬───────────────┬──────────────────────────────────────────────────────────┐
│    Library     │ Vulnerability  │ Severity │  Status  │ Installed Version │ Fixed Version │                          Title                           │
├────────────────┼────────────────┼──────────┼──────────┼───────────────────┼───────────────┼──────────────────────────────────────────────────────────┤
│ linux-libc-dev │ CVE-2023-0461  │ HIGH     │ affected │ 5.4.0-196.216     │               │ kernel: net/ulp: use-after-free in listening ULP sockets │
│                │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2023-0461                │
│                ├────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────┤
│                │ CVE-2023-20569 │          │          │                   │               │ amd: Return Address Predictor vulnerability leading to   │
│                │                │          │          │                   │               │ information disclosure                                   │
│                │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2023-20569               │
│                ├────────────────┤          │          │                   ├───────────────┼──────────────────────────────────────────────────────────┤
│                │ CVE-2023-21400 │          │          │                   │               │ kernel: io_uring: io_defer_entry object double free      │
│                │                │          │          │                   │               │ vulnerability                                            │
│                │                │          │          │                   │               │ https://avd.aquasec.com/nvd/cve-2023-21400               │
└────────────────┴────────────────┴──────────┴──────────┴───────────────────┴───────────────┴──────────────────────────────────────────────────────────┘

## Remediate the CVE:	



## What would you do to avoid deploying malicious packages?	
- Scan the image prior to deploying the envioronment, and require dependencies on the future builds for the scan to pass, along with having a manual deployment process to separate the CI and CD.
## K8s Deploy command:	
- kubectl create deployment nginx --image=getschwifty -- /bin/sh -c "while true; do sleep 30; done;"

## Expose the deployed resource:
-	kubectl expose deployment nginx --type=LoadBalancer --port=80 --target-port=9000

## How would you monitor the above deployment? Explain or implement the tools that you would use
- I'd use slack/teams to push notifications of the failures and this built into the pipeline. 
- Using tools like Newrelic or Datadog, ArgoCD. Grafana & Preometheus once the application was deployed.
