This repository contains the instructions to build the docker images with latest curl inside.
The automation pulls the source code from the [github.com](https://github.com/curl/curl) and does all the magic.
The multistage build is used to reduce the size of the resulting container.

The desired version of the curl can be specified in the CI file.

No compiler optimizations were enabled. 

The github actions were configured to build the image and push it into the [hub.docker.com](https://hub.docker.com/repository/docker/yyarmoshyk/curl-docker-image/general)

Curl binary is used as an ENTRYPOINT so the command `docker run -t --rm yyarmoshyk/curl-docker-image --version` will output the curl version.

The following command will print this readme file.
```bash
docker run -t --rm yyarmoshyk/curl-docker-image https://raw.githubusercontent.com/yyarmoshyk/curl-docker-image/main/Readme.md
```


I'm using [Azure container-scan](https://github.com/marketplace/actions/container-image-scan) to scan the image.