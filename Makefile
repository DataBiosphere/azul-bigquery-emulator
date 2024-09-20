SHELL=/bin/bash
registry_port=5000
git_remote=$(shell git remote | head -1)
VERSION ?= latest
REVISION := $(shell git rev-parse --short HEAD)
UNAME_OS := $(shell uname -s)
ifneq ($(UNAME_OS),Darwin)
	STATIC_LINK_FLAG := -linkmode external -extldflags "-static"
endif

emulator/build:
	CGO_ENABLED=1 CXX=clang++ go build -o bigquery-emulator \
		-ldflags='-s -w -X main.version=${VERSION} -X main.revision=${REVISION} ${STATIC_LINK_FLAG}' \
		./cmd/bigquery-emulator

docker/build:
	docker build -t bigquery-emulator . --build-arg VERSION=${VERSION}

start_registry:
	 docker run \
 		--rm \
 		--detach \
 		--publish $(registry_port):5000 \
 		--name registry registry:2.7

check_registry:
	@curl --fail http://localhost:$(registry_port)/ \
		|| { echo "Run 'make start_registry' first" ; false ; }

images: check_registry
	DOCKER_HOST=$$(docker context inspect --format '{{.Endpoints.docker.Host}}') \
	act \
		--env azul_docker_registry="localhost:$(registry_port)/" \
		--remote-name $(git_remote) \
		push

stop_registry:
	 docker stop registry
