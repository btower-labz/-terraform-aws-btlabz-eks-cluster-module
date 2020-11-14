#!/usr/bin/env bash

set -o nounset
set -o noclobber
set -o errexit
set -o pipefail
set -o xtrace

function log {
  echo "user_data: $1"
  logger --id "user_data: $1"
}

log 'started'

# Update packages
yum update --assumeyes && rc=$? || rc=$?
echo "update result is $rc"

/etc/eks/bootstrap.sh --apiserver-endpoint '${endpoint}' --b64-cluster-ca '${auth}' '${name}'

log 'finished'
