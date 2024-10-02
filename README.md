# BigQuery Emulator


BigQuery emulator server implemented in Go.  
BigQuery emulator provides a way to launch a BigQuery server on your local machine for testing and development.

## Azul Notes

Changes can be tested locally. You would need `make`, `curl`, Docker Desktop and 
[act](https://github.com/nektos/act). For example:

```
brew install act
act # the first invocation is to interactively configure `act`
make start_registry
make images
# scroll up in terminal output, note image name
# |   "image.name": "localhost:5000/docker.io/ucscgi/azul-bigquery-emulator:0.4.4-13"
docker pull localhost:5000/docker.io/ucscgi/azul-bigquery-emulator:0.4.4-13
# To examine the image for vulnerabilities, browse the image in Docker Desktop.
# If an unnecessary package is found to have critical or high vulnerabilities,
# To test the image in Azul, you will need to temporarily modify Azul's
# `environment.py` to set the appropriate `azul_docker_images` value using the
# full image name noted above (starting with "localhost").
cd ../azul
git diff
>    diff --git a/environment.py b/environment.py
>    index f7200b23..eb470058 100644
>    --- a/environment.py
>    +++ b/environment.py
>    @@ -292,8 +292,8 @@ def env() -> Mapping[str, Optional[str]]:
>                     'is_custom': True
>                 },
>                 'bigquery_emulator': {
>    -                'ref': 'docker.io/ucscgi/azul-bigquery-emulator:0.4.4-12',
>    -                'url': 'https://hub.docker.com/repository/docker/ucscgi/azul-bigquery-emulator',
>    +                'ref': 'localhost:5000/docker.io/ucscgi/azul-bigquery-emulator:0.4.4-13',
>    +                'url': 'localhost:5000/docker.io/ucscgi/azul-bigquery-emulator:0.4.4-13',
>                     'is_custom': True
make image_manifests.json
azul_docker_registry="" make test
cd -
make stop_registry
```
