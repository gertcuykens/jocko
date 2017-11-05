# Jocko cluster example

This will start a local three node cluster.

## Build

```bash
$ go get github.com/travisjeffery/jocko/...
$ cd $GOPATH/src/github.com/travisjeffery/jocko/cmd/jocko
$ go build
```

## Start the nodes

```bash
$ ./jocko broker \
          --debug \
          --log-dir="/tmp/jocko1" \
          --broker-addr=127.0.0.1:9092 \
          --raft-addr=127.0.0.1:9093 \
          --serf-addr=127.0.0.1:9094 \
          --http-addr=127.0.0.1:9095 \
          --id=1

$ ./jocko broker \
          --debug \
          --log-dir="/tmp/jocko2" \
          --broker-addr=127.0.0.1:9192 \
          --raft-addr=127.0.0.1:9193 \
          --serf-addr=127.0.0.1:9194 \
          --http-addr=127.0.0.1:9195 \
          --serf-members=127.0.0.1:9094 \
          --id=2

$ ./jocko broker \
          --debug \
          --log-dir="/tmp/jocko3" \
          --broker-addr=127.0.0.1:9292 \
          --raft-addr=127.0.0.1:9293 \
          --serf-addr=127.0.0.1:9294 \
          --http-addr=127.0.0.1:9295 \
          --serf-members=127.0.0.1:9094 \
          --id=3
```

## docker-compose cluster

To start a [docker compose](https://docs.docker.com/compose/) cluster use the provided `docker-compose.yml`.
