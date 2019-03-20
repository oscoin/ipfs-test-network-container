FROM ipfs/go-ipfs:v0.4.18

# Running as non-root user has some issues. Future go-ipfs images will
# be running as root again. See https://github.com/ipfs/go-ipfs/pull/6040
USER 0

# Default for running the 'ipfs' binary in the container.
ENV IPFS_PATH=/data/1

EXPOSE 4001
EXPOSE 5001

VOLUME /data

COPY . /app

# -g option stops all processes in the process group on SIGINT
ENTRYPOINT ["/sbin/tini", "-g", "--", "/app/entrypoint.sh"]
