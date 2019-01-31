#!/bin/sh
set -eo pipefail

case $1 in
  -*) exec /app/start-swarm.sh "$@";;
  "") exec /app/start-swarm.sh;;
  *) exec "$@";;
esac
