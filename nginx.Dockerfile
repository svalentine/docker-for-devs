FROM php:7.2-cli AS builder

ARG DOCKERIZE_VERSION=v0.6.1

COPY --chown=0:0 web/ /build
COPY --chown=0:0 infrastructure/nginx /infrastructure

RUN set -ex ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends wget ; \
    wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz ; \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz ; \
    rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz ; \
    mv /infrastructure/*.tmpl /opt/templates ; \
    

FROM nginx:1.15.8

COPY --from=builder /usr/local/bin /usr/local/bin 
COPY --from=builder /build app/web
COPY --from=builder /infrastructure/*.tmpl /opt/templates
COPY --from=builder /infrastructure/entrypoint.sh /entrypoint.sh

RUN set -ex ; \
    mkdir -p /app/var 







