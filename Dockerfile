FROM ipfs/go-ipfs

# Default for running the 'ipfs' binary in the container.
ENV IPFS_PATH=/data/1

EXPOSE 4001
EXPOSE 5001

VOLUME /data

COPY . /app

# -g option stops all processes in the process group on SIGINT
ENTRYPOINT ["/sbin/tini", "-g", "--", "/app/entrypoint.sh"]
