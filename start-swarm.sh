#!/bin/sh
set -eo pipefail

ipfs version

if [ ! -e /data/swarm.key ]; then
  echo "Generating swarm key"
  echo "/key/swarm/psk/1.0.0/" >> /data/swarm.key
  echo "/base16/" >> /data/swarm.key
  hexdump -n 32 -e '8/4 "%08x" 1 "\n"' /dev/urandom >> /data/swarm.key
fi

/app/start-node.sh 1 &
/app/start-node.sh 2 &

while true; do
  sleep 1000
done
