SHELL=/bin/bash
registry_port=5000
VERSION ?= latest
REVISION := $(shell git rev-parse --short HEAD)
UNAME_OS := $(shell uname -s)
ifneq ($(UNAME_OS),Darwin)
	STATIC_LINK_FLAG := -linkmode external -extldflags "-static"
endif

.PHONY: emulator/build
emulator/build:
	CGO_ENABLED=1 \
	CXX=clang++ \
	CGO_CFLAGS="-fno-PIC"  CGO_CPPFLAGS="-fno-PIC"  CGO_CXXFLAGS="-fno-PIC" \
		go build -o bigquery-emulator \
			-ldflags='-s -w -X main.version=${VERSION} -X main.revision=${REVISION} ${STATIC_LINK_FLAG}' \
			./cmd/bigquery-emulator

# Copy environment variable definitions from GitHub Actions build so we don't
# need to duplicate them here for a local build:

env.mk: .github/workflows/build.yml $(MAKEFILE_LIST)
	cat $< \
		| yq -o json .env \
		| jq -r 'to_entries|.[]|(.key+" ?= "+(.value|tostring))' \
		> $@

-include env.mk

azul_docker_registry := "localhost:$(registry_port)/"

.PHONY: docker/build
docker/build:
	docker build \
		--progress=plain \
		--build-arg azul_docker_bigquery_emulator_base_image_tag=$(azul_docker_bigquery_emulator_base_image_tag) \
		--build-arg azul_docker_bigquery_emulator_upstream_version=$(azul_docker_bigquery_emulator_upstream_version) \
		--build-arg azul_docker_bigquery_emulator_internal_version=$(azul_docker_bigquery_emulator_internal_version) \
		--build-arg azul_docker_go_zetasql_image=$(azul_docker_go_zetasql_image) \
		--build-arg azul_docker_go_zetasql_upstream_version=$(azul_docker_go_zetasql_upstream_version) \
		--build-arg azul_docker_go_zetasql_internal_version=$(azul_docker_go_zetasql_internal_version) \
		--tag $(azul_docker_registry)$(azul_docker_bigquery_emulator_image):$(azul_docker_bigquery_emulator_upstream_version)-$(azul_docker_bigquery_emulator_internal_version) \
		.

.PHONY: start_registry
start_registry:
	 docker run \
 		--rm \
 		--detach \
 		--publish $(registry_port):5000 \
 		--name registry \
 		registry:2.7

.PHONY: check_registry
check_registry:
	@curl --fail http://localhost:$(registry_port)/ \
		|| { echo "Run 'make start_registry' first" ; false ; }

.PHONY: images
images: check_registry docker/build
	docker push $(azul_docker_registry)$(azul_docker_bigquery_emulator_image):$(azul_docker_bigquery_emulator_upstream_version)-$(azul_docker_bigquery_emulator_internal_version)

.PHONY: stop_registry
stop_registry:
	 docker stop registry
