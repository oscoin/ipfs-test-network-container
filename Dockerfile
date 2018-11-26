FROM ipfs/go-ipfs

# Default for running the 'ipfs' binary in the container.
ENV IPFS_PATH=/data/1

EXPOSE 4001
EXPOSE 5001

VOLUME /data

# Overwrite entry point from base image
ENTRYPOINT []

COPY . /app

# -g option stops all processes in the process group on SIGINT
CMD ["/sbin/tini", "-g", "--", "/app/start-swarm.sh"]
