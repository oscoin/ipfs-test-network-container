#!/bin/sh
set -eo pipefail

node_id=$1
IPFS_PATH="/data/$node_id"

if [ ! -e "$IPFS_PATH/config" ]; then
  echo "init node"
  ipfs init
  cp /data/swarm.key "$IPFS_PATH"
  ipfs bootstrap rm all >/dev/null
  ipfs config Addresses.API "/ip4/0.0.0.0/tcp/500${node_id}"
  ipfs config Addresses.Gateway "/ip4/0.0.0.0/tcp/808${node_id}"
  ipfs config Addresses.Swarm --json "[\"/ip4/127.0.0.1/tcp/400${node_id}\"]"
fi

ipfs daemon
