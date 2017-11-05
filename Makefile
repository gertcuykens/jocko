BUILD_PATH := jocko
DOCKER_TAG := latest

all: deps test

deps:
	@which dep 2>/dev/null || go get -u github.com/golang/dep/cmd/dep
	dep ensure

build:
	go build -o $(BUILD_PATH) cmd/jocko/main.go

build-docker:
	docker build -t travisjeffery/jocko:$(DOCKER_TAG) .

rund:
# docker run --rm -it travisjeffery/jocko /bin/sh
	docker run --rm travisjeffery/jocko jocko broker \
		--debug \
		--log-dir="/tmp/jocko" \
		--broker-addr=127.0.0.1:9092 \
		--raft-addr=127.0.0.1:9093 \
		--serf-addr=127.0.0.1:9094 \
		--http-addr=127.0.0.1:9095 \
		--id=1

run: clean
	jocko broker \
		--debug \
		--log-dir="/tmp/jocko" \
		--broker-addr=127.0.0.1:9092 \
		--raft-addr=127.0.0.1:9093 \
		--serf-addr=127.0.0.1:9094 \
		--http-addr=127.0.0.1:9095 \
		--id=1

clean:
	rm -rf /tmp/jocko/*

test:
	go test -v ./...

test-race:
	go test -v -race -p=1 ./...

.PHONY: all deps build build-docker run rund test test-race
