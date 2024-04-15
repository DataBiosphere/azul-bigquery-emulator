ARG azul_docker_bigquery_emulator_base_image_tag

FROM ghcr.io/goccy/go-zetasql:latest

ARG VERSION

WORKDIR /work

COPY . ./

RUN go mod edit -replace github.com/goccy/go-zetasql=../go-zetasql
RUN go mod download

RUN make emulator/build

FROM debian:${azul_docker_bigquery_emulator_base_image_tag} AS emulator

ARG azul_docker_bigquery_emulator_internal_version

RUN apt-get update && apt-get upgrade -y

COPY --from=0 /work/bigquery-emulator /bin/bigquery-emulator

WORKDIR /work

ENTRYPOINT ["/bin/bigquery-emulator"]
