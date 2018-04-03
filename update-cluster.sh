#!/bin/bash
set -euo pipefail

source ./config.sh

kops update cluster \
  --state $KOPS_STATE_STORE \
  --out=terraform/$NAME \
  --target terraform \
  --name $NAME
