# Creating Images #

## Aim ##

In this example, we will be creating a basic PHP application with it's infrastructure.
The infrastructure will contain 

- nginx (as the web server)
- php-fpm (as the interpreter)
- mysql (as the data storage layer)
- memcached (as the cache layer)

If there is time, we can also attempt to create a queue producer and consumer. This will require

- rabbitmq (as broker)
- golang (as the consumer)

## Dockerfile ##

For the canonical documentation on Dockerfiles, be sure to check out https://docs.docker.com/engine/reference/builder/ & https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

In this slide, we will start with a basic nginx configuration. Since we are only interested in that single container we will make smaller changes

The [Dockerfile](./Dockerfile) we will be using is in the root of this project.
In order to see how this container is built, lets take a look at

- https://hub.docker.com/_/nginx
- https://github.com/nginxinc/docker-nginx/blob/baa050df601b5e798431a9db458e16f53b1031f6/mainline/stretch/Dockerfile

You can build it with `docker build -t nginx:basic-docker-for-devs-static .`. 
This will create a base layer tagged with `nginx:basic-docker-for-devs-static`.

Now we can see that the image has been created with `docker images -a | grep basic-docker-for-devs-static`

```text
REPOSITORY TAG                            IMAGE ID       CREATED        SIZE
nginx      basic-docker-for-devs-static   d3f19b63a889   3 minutes ago  109MB
```

You will notice that there is no container yet for this image.

### Creating a container from the image ###

The documentation for docker run is available here: https://docs.docker.com/engine/reference/run/

`docker run --name nginx-static -d -p 8080:80 nginx:basic-docker-for-devs-static`

Now visit http://localhost:8080/ and you should be greeted with a welcome page.

#### Debugging if something went wrong (or even if it didn't) ####

`docker logs nginx-static` will display any startup errors, as well as any requests.

## Cleaning up ##

Now that we have built the container and it's using hard baked files lets remove it.

First we need to stop the container with
`docker stop nginx-static` to stop the running container.
`docker rm nginx-static` to remove the running container.
`docker rmi nginx:basic-docker-for-devs-static` to remove the underlying image.

Note: if you do it in a different order (remove the image before stopping the 
container for example) you will get an error similar to:
`Error response from daemon: conflict: unable to remove repository reference "nginx:basic-docker-for-devs-static" (must force) - container e0fa40f1e1dd is using its referenced image 250298d668d4`

In this example you can figure out which container with `docker ps -a | grep e0fa40f1e1dd`,
and which image with `docker images -a | grep 250298d668d4`

## Next steps ##

```bash
git checkout slide-4
```

## More information ##

You can also get more info directly from their getting started guide at https://docs.docker.com/get-started/
