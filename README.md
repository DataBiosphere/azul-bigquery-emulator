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
its sister repository `go-zetasqlite`.

To update this repository's dependency on `go-zetasqlite` after you pushed a 
commit to the `azul` branch in our fork of that repository, run 

```
go mod edit -replace github.com/goccy/go-zetasqlite=github.com/DataBiosphere/azul-go-zetasqlite@azul
go mod tidy
```

and commit the resulting changes to this repository.