This repository contains the instructions to build the dockerfile with latest curl inside.
The automation pulls that source code from the [github.com](https://github.com/curl/curl) and does all the magic.
The multistage build is used to reduce the size of the resulting container.

No compiler optimizations were enabled. 

The github actions were configured to build the image and push it into the [hub.docker.com](https://hub.docker.com/repository/docker/yyarmoshyk/curl-docker-image/general)

Curl binary is used as an ENTRYPOINT so the command `docker run -t --rm yyarmoshyk/curl-docker-image:main --version` will output the curl version.

The following command will print this readme file.
```bash
docker run -t --rm yyarmoshyk/curl-docker-image:main https://raw.githubusercontent.com/yyarmoshyk/curl-docker-image/main/Readme.md
```


I'm using sysdig.com trial account to scan the image.