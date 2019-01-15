# Introducing docker-compose #

## Documentation ##

The documentation for docker-compose is available here: https://docs.docker.com/compose/,
or more specifically at https://docs.docker.com/compose/compose-file/

Most options aren't useful for developers (c-groups, dns settings). We will look 
at some common configurations here:

- context: https://docs.docker.com/compose/compose-file/#context
- dockerfile: https://docs.docker.com/compose/compose-file/#dockerfile
- args: https://docs.docker.com/compose/compose-file/#args
- labels: https://docs.docker.com/compose/compose-file/#labels & https://docs.docker.com/config/labels-custom-metadata/ 
- depends_on: https://docs.docker.com/compose/compose-file/#depends_on
- entrypoint: https://docs.docker.com/compose/compose-file/#entrypoint
- environment (and env_file): Compare with secrets - https://docs.docker.com/compose/compose-file/#environment & https://docs.docker.com/compose/compose-file/#env_file
- expose: https://docs.docker.com/compose/compose-file/#expose (Compare with ports)
- extra_hosts: https://docs.docker.com/compose/compose-file/#extra_hosts
- image: https://docs.docker.com/compose/compose-file/#image
- labels: https://docs.docker.com/compose/compose-file/#labels
- links (depreciated): https://docs.docker.com/compose/compose-file/#links
- networks: https://docs.docker.com/compose/compose-file/#networks
- ports: https://docs.docker.com/compose/compose-file/#ports
- secrets: https://docs.docker.com/compose/compose-file/#secrets
- volumes: https://docs.docker.com/compose/compose-file/#volumes

You will notice that I embed the options for several of these options within my `*Dockerfile`.
Discuss pro/con

## Aim ##

In the next few slides, we will be creating a basic PHP application with it's infrastructure.
The infrastructure will contain

- nginx (as the web server)
- php-fpm (as the interpreter)
- mysql (as the data storage layer)
- memcached (as the cache layer)
- rabbitmq (as broker)
- golang (as the consumer)

## Configuration Options ##

At this point you should have a basic understanding of the options that go into compose and Dockerfiles.

## Next steps ##

AND DONE !

## Some things to try ##

How would you streamline this docker-compose*.yml ?

### Extending Memcached ###

Lets assume that you discover that the memcached default size of 64MB is
insufficient for your needs.

You decide to create a new layer that allows the size of the cache to be determined 
from an environment variable. How do you implement it?
