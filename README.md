# BigQuery Emulator


BigQuery emulator server implemented in Go.  
BigQuery emulator provides a way to launch a BigQuery server on your local machine for testing and development.

## Azul Notes

### Testing the emulator image locally

Changes can be tested locally. You need Docker Desktop, `make`, `curl` and `yq`.
The latter can be installed on macOS using Homebrew. 

For example:

```
$ make start_registry
$ make images
…
docker build \
                --progress=plain \
                …
                --tag "localhost:5000/"docker.io/ucscgi/azul-bigquery-emulator:0.4.4-26 \
                .
#0 building with "desktop-linux" instance using docker driver
…
#18 writing image sha256:dc7560d7d80c6ff20b23d956c17e5d07950fe5e48b6ad1b239d9a08e7e7bbf12 done
#18 naming to localhost:5000/docker.io/ucscgi/azul-bigquery-emulator:0.4.4-26 done
#18 DONE 0.0s
…
docker push "localhost:5000/"docker.io/ucscgi/azul-bigquery-emulator:0.4.4-26
The push refers to repository [localhost:5000/docker.io/ucscgi/azul-bigquery-emulator]
…
948048d45864: Layer already exists 
0.4.4-26: digest: sha256:3a722a8ba99fb93d1ce432493fb2970454df685003b88af002c83d379af27efc size: 1159
```

Note the image ID (`sha256:dc75…`), the image digest (`sha256:3a72…`) and the
image name (`localhost:5000/docker.io/ucscgi/azul-bigquery-emulator`).

To examine the image for vulnerabilities, browse the image in Docker Desktop.

To test the image with Azul, you will need to temporarily modify Azul's
`environment.py` to set the appropriate `azul_docker_images` value using the
fully qualified image name noted above:

```diff
Index: environment.py
IDEA additional info:
Subsystem: com.intellij.openapi.diff.impl.patch.CharsetEP
<+>UTF-8
===================================================================
diff --git a/environment.py b/environment.py
--- a/environment.py	(revision f7c3bee28f2abf8fd31319e6c9764f0d956e265b)
+++ b/environment.py	(date 1744046825705)
@@ -306,7 +306,7 @@
                 'is_custom': True
             },
             'bigquery_emulator': {
-                'ref': 'docker.io/ucscgi/azul-bigquery-emulator:0.4.4-26',
+                'ref': 'localhost:5000/docker.io/ucscgi/azul-bigquery-emulator:0.4.4-26',
                 'url': 'https://hub.docker.com/repository/docker/ucscgi/azul-bigquery-emulator',
                 'is_custom': True
             },
```

After making this temporary change, run the Makefile target for updating the
image's digest and ID in `image_manifests.json` and start the test. It is
important to disable the ECR mirror by setting `azul_docker_registry` to the
empty string:

```
$ cd ../azul
$ make image_manifests.json
$ azul_docker_registry="" make test
$ cd -
$ make stop_registry
```

### Updating Zeta SQL dependencies

Along with forking `bigquery-emulator` (this repository), we also forked two of 
its sister repositories: `go-zetasqlite` and `go-zetasql`.

To update this repository's dependency on `go-zetasqlite` after you pushed a 
commit to the `azul` branch in our fork of that repository, i.e., 
`azul-go-zetasqlite`, run 

```
go mod edit -replace github.com/goccy/go-zetasqlite=github.com/DataBiosphere/azul-go-zetasqlite@azul
go mod tidy
```

Commit the resulting changes to this repository.

`go mod tidy` uses a caching proxy at golang.org to access version info on 
github.com. I've observed that cache to be stale, especially after pushing tags. 
To bypass the cache, use `GOPRIVATE=github.com/DataBiosphere/* go mod tidy`.   

After updates to `azul-go-zetasql` a similar procedure needs to be performed on
`azul-go-zetasqlite`:

```
go mod edit -replace github.com/goccy/go-zetasql=github.com/DataBiosphere/azul-go-zetasql@azul
go mod tidy
```

Commit the resulting changes to `azul-go-zetasqlite`, run the above two pairs
of commands (the one for `go-zetasql` and the one for `azul-go-zetasqlite` 
against this repository and commit the resulting changes to this repository as 
well.  

The first build stage of the BQ emulator image uses as its base an image
produced by a GitHub Actions build for the `go-zetasql` repository. So in
addition to updating the Go dependency as described above, the base image
reference needs to be updated. This is done via the `azul_docker_go_zetasql_…`
variables in `.github/workflows/build.yml` for both `azul-go-zetasql` and this
repository. The commit to `azul-go-zetasql` would have had to include at least
an increment to `azul_docker_go_zetasql_internal_version`. Note that we do not
mirror the `go-zetasql` image to ECR as it is used only by the GitHub Actions
build for this repository, and `make images` (see above). The former does not 
have access to the ECR mirror as the mirror is not public.
