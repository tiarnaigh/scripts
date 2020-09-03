#/bin/bash
# Find top iNodes in a given directory
# Example: 
# root@jenkinsk8s-78db78487c-gpkld:/# find /var/jenkins_home/ -xdev -printf '%h\n' | sort | uniq -c | sort -k 1 -n | tail -20
#   1099 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/44/workflow
#   1112 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/43/workflow
#   1115 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/45/workflow
#   1143 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/47/workflow
#   1146 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/46/workflow
#   1156 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/48/workflow
#   1170 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/52/workflow
#   1184 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/53/workflow
#   1195 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/54/workflow
#   1364 /var/jenkins_home/jobs/INFRA/jobs/Dublin/jobs/pipeline-repos/branches/master/builds/35/workflow

find /var/jenkins_home/ -xdev -printf '%h\n' | sort | uniq -c | sort -k 1 -n
