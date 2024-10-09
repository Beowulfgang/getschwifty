# Project GetSchwifty


## DockerHublink: 
https://hub.docker.com/repository/docker/beowulfgang/getschwifty
## Buildtime:	
- 61.1s

## What can I do to improve:	
- I'd cache the build either in S3 storage or some form of caching. I could also change the build image to something slimmer. 

## Scanned Report is apart of the build:	
- [https://github.com/Beowulfgang/getschwifty/actions/runs/11245577438/job/31265842087#step:6:58](https://github.com/Beowulfgang/getschwifty/actions/runs/11245708275/job/31266231312)

## Remediate the CVE:
- CVE-2022-48739 (ASoC: hdmi-codec: Fix OOB memory accesses)
- apt-get upgrade

## What would you do to avoid deploying malicious packages?	
- Scan the image prior to deploying the envioronment, and require dependencies on the future builds for the scan to pass, along with having a manual deployment process to separate the CI and CD.
## K8s Deploy command:	
- kubectl create deployment nginx --image=getschwifty -- /bin/sh -c "while true; do sleep 30; done;"

## Expose the deployed resource:
-	kubectl expose deployment nginx --type=LoadBalancer --port=80 --target-port=9000

## How would you monitor the above deployment? Explain or implement the tools that you would use
- I'd use slack/teams to push notifications of the failures and this built into the pipeline. 
- Using tools like Newrelic or Datadog, ArgoCD. Grafana & Preometheus once the application was deployed.

## Workflow or other tool that will allow people to select options for: 

https://github.com/Beowulfgang/getschwifty/blob/main/.github/workflows/actions.yml  

a. Base image
b. Packages
c. Mem/CPU/GPU requests

## Monitor each environment and make sure that:
- Time boxed and did not get to this specifcally. Do see /terraform-eks for the auto-scaling config that might solve some of these.
- HPA example
- Spot Sintance
- Cluster Autoscaler

## The cluster needs to automatically handle up/down scaling and have multiple instance groups/taints/tags/others to be chosen from in order to segregate resources usage between teams/resources/projects/others
- See /terraform-eks

## SFTP, SSH or similar access to the deployed environment is needed so DNS handling automation is required
- Port 22 is open
- DNS is apart of the build pipeline
- Enable SSH on the K8s cluster.


# Could you talk about a time when you needed to bring the data to the code, and how you architected this system?
- There was a data set that required an integration and re-mapping of the data. I had to prevent overloading the memory by creating a queuing system using SQS to prvent the memory overloading. Data was streamed into chunks and was done through multiple nodes/pods. 
Another specific issue I've worked on was SQL scripts with databases around 10TB, and reconfiguring and splicing the data up.


# If you don’t have an example, could you talk through how you would go about architecting this?
- While I haven't worked with 100-250GB of data in code, I have worked and handled large datasets analyzing logs, usuing tools like Druid, and ELK/Opensearch. I would create a distrubted system that spans across multiple nodes, where data is to be partitioned and spliced. Caching would be another portion, memory mapping files.
- I would also architect this with specific hardware that was meant for large datasets. 

# How would you monitor memory usage/errors?
  -  I would use Grafana and Prometheus. I'd make sure to monitor the heap memory, disks.
  -  I'd create alerts around the standard threshold and, alert on any OOM, while also making sure auto-scaling and failures are able to automatically recover(HPA/Cluster Scaling) and alert when this is done. 


  
