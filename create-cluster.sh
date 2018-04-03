#!/bin/bash
set -euo pipefail

source ./config.sh

arguments=(
"--node-count 2"                                  # start with two nodes, can be changed later
"--cloud aws"                                     # just in case its not obvious, use AWS
"--state $KOPS_STATE_STORE"                       # set state store, this is where Kops keeps track of things for us
"--zones us-east-1a,us-east-1b,us-east-1c"        # use 3 availability zones for redundancy
"--master-zones us-east-1a,us-east-1b,us-east-1c" # use those 3 zones for the masters as well                                                                                                                                                  "--dns private"                                   # everything is private here, no internet-accessible DNS
"--dns-zone $DNS_ZONE"                            # set proper dns zone
"--node-size c4.2xlarge"                          # set node size, can be changed later
"--master-size t2.medium"                         # set master size, these can be smallish but can also be changed later
"--target terraform"                              # output all configuration to terraform files instead of applying directly
"--out terraform/$NAME"                           # where to put that terraform output
#see an overview of networking options at https://chrislovecnm.com/kubernetes/cni/choosing-a-cni-provider/
"--topology private"                              # do not assign public IP addresses. any internet access needed will be done with ELBs
"--networking flannel"                            # use flannel for networking
"--bastion"                                       # use a single bastion host that will be the only internet-accessible machine to SSH into
"--name=$NAME"                                    # set the name of the cluster
)

echo ${arguments[@]}
sleep 2
kops create cluster ${arguments[@]}
