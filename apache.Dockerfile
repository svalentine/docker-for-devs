FROM php:5.6.36-apache-stretch

ARG DOCKERIZE_VERSION=v0.6.1

COPY --chown=0:0 app-web/ /app
COPY --chown=0:0 infrastructure/apache /infrastructure

RUN set -ex ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends \
        git \
        libmemcached-dev \
        wget \
        zlib1g-dev ; \    
    wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz ; \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz ; \
    rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz ; \
    mv /infrastructure/*.tmpl /opt/templates ; \
    docker-php-ext-install bcmath ; \
    docker-php-ext-enable bcmath ; \
    docker-php-ext-install sockets ; \
    docker-php-ext-enable sockets ; \
    wget https://getcomposer.org/installer -O - | php -- --install-dir=/usr/local/bin --filename=composer ; \
    cd /app ; \
    composer install

WORKDIR /app
# ENTRYPOINT [ "/docker-entrypoint.sh" ]
