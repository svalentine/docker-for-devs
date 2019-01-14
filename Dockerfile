# We are using the base ubuntu image here since we only care about optipng
FROM ubuntu:18.04 AS builder

COPY html /html

RUN set -ex ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends optipng ; \    
    mkdir -p /usr/share/nginx/html ; \
    chmod 0755 /usr/share/nginx/html ; \
    cp -v /html/*.html /usr/share/nginx/html ; \
    optipng --clobber /html/docker.png ; \
    cp -v /html/*.png /usr/share/nginx/html

# We could setup other builders here (e.g. composer, pip, npm, etc)


# The final image will use nginx
FROM nginx:1.15.8

## We have now got the optimised html/css/images in  /usr/share/nginx/html
## So we only create a single layer with those respources.
COPY --from=builder /usr/share/nginx/html /usr/share/nginx/html

EXPOSE 80
