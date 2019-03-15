#!/bin/sh
set -eo pipefail

ipfs version

if [ ! -e /data/swarm.key ]; then
  echo "Generating swarm key"
  echo "/key/swarm/psk/1.0.0/" >> /data/swarm.key
  echo "/base16/" >> /data/swarm.key
  hexdump -n 32 -e '8/4 "%08x" 1 "\n"' /dev/urandom >> /data/swarm.key
fi

function ensure_ipfs_init () {
  node_id=$1
  IPFS_PATH="/data/$node_id"
  if [ ! -e "$IPFS_PATH/config" ]; then
    echo "init node $1"
    ipfs init
    cp /data/swarm.key "$IPFS_PATH"
    ipfs bootstrap rm all >/dev/null
    # Dummy boostrap node to prevent error messages
    ipfs bootstrap add /ip4/127.0.0.1/tcp/1/ipfs/QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ
    ipfs config Addresses.API "/ip4/0.0.0.0/tcp/500${node_id}"
    ipfs config Addresses.Gateway "/ip4/0.0.0.0/tcp/808${node_id}"
    ipfs config Addresses.Swarm --json "[\"/ip4/127.0.0.1/tcp/400${node_id}\"]"
  fi
}

function run_ipfs () {
  IPFS_PATH="/data/$1"
  shift
  ipfs "$@"
}

ensure_ipfs_init 1
ensure_ipfs_init 2

run_ipfs 1 daemon "$@" &
run_ipfs 2 daemon "$@" &

# Make sure the daemons have started
sleep 1

# Explicitly connect the daemons
addr1=$(run_ipfs 1 id -f "<addrs>\n")
run_ipfs 2 swarm connect "$addr1"

wait %%
