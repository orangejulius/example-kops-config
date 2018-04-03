#!/bin/bash

# Cluster Name
export NAME="your-cluster.k8s.yourdomain.com"

# Kops State Store
export KOPS_STATE_STORE="s3://kops-state-store.yourdomain.com"

export DNS_ZONE="XXXXXXXXXXXXX" # AWS route53 DNS zone for nextzen.coffeelytics.com

# echo some key variables to show they are set
echo "NAME=$NAME"
env | grep KOPS
env | grep AWS_PROFILE || true
