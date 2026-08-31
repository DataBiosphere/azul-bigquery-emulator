module github.com/goccy/bigquery-emulator

go 1.27.0

require (
	cloud.google.com/go/bigquery v1.82.0
	cloud.google.com/go/storage v1.66.0
	github.com/GoogleCloudPlatform/golang-samples/bigquery v0.0.0-20260624000252-7bcce5ac11ab
	github.com/apache/arrow/go/v10 v10.0.1
	github.com/fsouza/fake-gcs-server v1.54.0
	github.com/go-playground/validator/v10 v10.30.3
	github.com/goccy/go-json v0.10.6
	github.com/goccy/go-yaml v1.19.2
	github.com/goccy/go-zetasql v0.5.5
	github.com/goccy/go-zetasqlite v0.20.0
	github.com/google/go-cmp v0.7.0
	github.com/googleapis/gax-go/v2 v2.24.0
	github.com/gorilla/mux v1.8.1
	github.com/jessevdk/go-flags v1.6.1
	github.com/linkedin/goavro/v2 v2.15.0
	github.com/parquet-go/parquet-go v0.32.0
	go.uber.org/zap v1.28.0
	golang.org/x/sync v0.22.0
	google.golang.org/api v0.296.0
	google.golang.org/genproto v0.0.0-20260831171406-18b4a7587f8a
	google.golang.org/genproto/googleapis/rpc v0.0.0-20260831171406-18b4a7587f8a
	google.golang.org/grpc v1.83.2
	google.golang.org/protobuf v1.36.12
)

require (
	cel.dev/expr v0.25.3 // indirect
	cloud.google.com/go v0.123.0 // indirect
	cloud.google.com/go/auth v0.23.2 // indirect
	cloud.google.com/go/auth/oauth2adapt v0.2.8 // indirect
	cloud.google.com/go/compute/metadata v0.9.0 // indirect
	cloud.google.com/go/iam v1.13.0 // indirect
	cloud.google.com/go/monitoring v1.30.0 // indirect
	cloud.google.com/go/pubsub/v2 v2.6.0 // indirect
	github.com/DataDog/go-hll v1.0.2 // indirect
	github.com/GoogleCloudPlatform/opentelemetry-operations-go/detectors/gcp v1.37.0 // indirect
	github.com/GoogleCloudPlatform/opentelemetry-operations-go/exporter/metric v0.61.0 // indirect
	github.com/GoogleCloudPlatform/opentelemetry-operations-go/internal/resourcemapping v0.61.0 // indirect
	github.com/andybalholm/brotli v1.2.3 // indirect
	github.com/apache/arrow/go/v15 v15.0.2 // indirect
	github.com/apache/thrift v0.24.0 // indirect
	github.com/cespare/xxhash/v2 v2.3.0 // indirect
	github.com/cncf/xds/go v0.0.0-20260202195803-dba9d589def2 // indirect
	github.com/dgryski/go-farm v0.0.0-20240924180020-3414d57e47da // indirect
	github.com/dlclark/regexp2/v2 v2.7.1 // indirect
	github.com/dop251/goja v0.0.0-20260826204918-8f1c0696a37b // indirect
	github.com/envoyproxy/go-control-plane/envoy v1.39.0 // indirect
	github.com/envoyproxy/protoc-gen-validate v1.3.3 // indirect
	github.com/felixge/httpsnoop v1.1.0 // indirect
	github.com/gabriel-vasile/mimetype v1.4.15 // indirect
	github.com/go-jose/go-jose/v4 v4.1.4 // indirect
	github.com/go-logr/logr v1.4.4 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-playground/locales v0.14.1 // indirect
	github.com/go-playground/universal-translator v0.18.1 // indirect
	github.com/go-sourcemap/sourcemap v2.1.4+incompatible // indirect
	github.com/golang/snappy v1.0.0 // indirect
	github.com/google/flatbuffers v25.12.19+incompatible // indirect
	github.com/google/pprof v0.0.0-20260830191439-4932ad3515ea // indirect
	github.com/google/renameio/v2 v2.0.2 // indirect
	github.com/google/s2a-go v0.1.9 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/googleapis/enterprise-certificate-proxy v0.3.21 // indirect
	github.com/gorilla/handlers v1.5.2 // indirect
	github.com/klauspost/asmfmt v1.3.2 // indirect
	github.com/klauspost/compress v1.19.2 // indirect
	github.com/klauspost/cpuid/v2 v2.4.0 // indirect
	github.com/leodido/go-urn v1.5.0 // indirect
	github.com/mattn/go-sqlite3 v1.14.50 // indirect
	github.com/minio/asm2plan9s v0.0.0-20200509001527-cdd76441f9d8 // indirect
	github.com/minio/c2goasm v0.0.0-20190812172519-36a3d3bbc4f3 // indirect
	github.com/parquet-go/bitpack v1.1.0 // indirect
	github.com/parquet-go/jsonlite v1.5.5 // indirect
	github.com/pierrec/lz4/v4 v4.1.29 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/pkg/xattr v0.4.12 // indirect
	github.com/planetscale/vtprotobuf v0.6.1-0.20240319094008-0393e58bdf10 // indirect
	github.com/spaolacci/murmur3 v1.1.0 // indirect
	github.com/spiffe/go-spiffe/v2 v2.8.1 // indirect
	github.com/twpayne/go-geom v1.6.1 // indirect
	github.com/zeebo/xxh3 v1.1.0 // indirect
	go.opencensus.io v0.24.0 // indirect
	go.opentelemetry.io/auto/sdk v1.2.1 // indirect
	go.opentelemetry.io/contrib/detectors/gcp v1.46.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.71.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.71.0 // indirect
	go.opentelemetry.io/otel v1.46.0 // indirect
	go.opentelemetry.io/otel/metric v1.46.0 // indirect
	go.opentelemetry.io/otel/sdk v1.46.0 // indirect
	go.opentelemetry.io/otel/sdk/metric v1.46.0 // indirect
	go.opentelemetry.io/otel/trace v1.46.0 // indirect
	go.uber.org/multierr v1.11.0 // indirect
	golang.org/x/crypto v0.55.0 // indirect
	golang.org/x/exp v0.0.0-20260824195058-e88cd73687aa // indirect
	golang.org/x/mod v0.40.0 // indirect
	golang.org/x/net v0.58.0 // indirect
	golang.org/x/oauth2 v0.36.0 // indirect
	golang.org/x/sys v0.47.0 // indirect
	golang.org/x/telemetry v0.0.0-20260828145429-86cb5733f5b7 // indirect
	golang.org/x/text v0.41.0 // indirect
	golang.org/x/time v0.15.0 // indirect
	golang.org/x/tools v0.49.0 // indirect
	golang.org/x/xerrors v0.0.0-20240903120638-7835f813f4da // indirect
	gonum.org/v1/gonum v0.17.0 // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20260831171406-18b4a7587f8a // indirect
)

replace github.com/goccy/go-zetasqlite => github.com/DataBiosphere/azul-go-zetasqlite v0.18.1-0.20260831211414-032a9f0265f1

replace github.com/goccy/go-zetasql => github.com/DataBiosphere/azul-go-zetasql v0.5.6-0.20260831211045-0ac85b24c29f
