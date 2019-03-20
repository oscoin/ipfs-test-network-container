IPFS Test Network Container
===========================

Run an isolated, private IPFS network in a Docker container.

The container runs two IPFS nodes that share a [private IPFS
network][ipfs-private-network]. This allows for isolation from the main IPFS
network and fast and reliable responses, especially with IPNS.

[ipfs-private-network]: https://github.com/ipfs/go-ipfs/blob/master/docs/experimental-features.md#private-networks

Usage
-----

```
docker run \
  --volume ipfs-test-data:/data \
  --publish 4001:4001 \
  --publish 5001:5001 \
  --name ipfs-test-network
  gcr.io/opensourcecoin/ipfs-test-network
```

To wait until the nodes have connected to each other run
```
docker run ipfs-test-network /app/wait-until-ready
```
The command will timeout after 10 seconds and exit with status code 1.


You can now talk to a node in the test network from your host machine through
the `ipfs` CLI.

```
ipfs --api /ip4/127.0.0.1/tcp/5001 swarm peers
```

You can pass options to all nodes in the network

```
docker run \
  ipfs-test-network \
  --enable-pubsub-experiment
```

You can also use the `ipfs` executable inside the container

```
docker exec -it ipfs-test-network ipfs swarm peers
```

The IPFS repos for the two nodes live in `/data/0` and `/data/1`.

### Image tags

For every master build we provide an image tagged with the short commit SHA.
(That is the first seven characters of the Git commit SHA.) The latest image
build from master has the `latest` tag.

License
-------

Copyright 2018 Monadic GmbH

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
