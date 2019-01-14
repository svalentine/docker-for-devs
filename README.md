# Creating Images #

## Builder Pattern ##

Multi-stage builds are a new feature requiring Docker 17.05 or higher on the
daemon and client. Multi-Stage builds are useful to anyone who has struggled to
optimize Dockerfiles while keeping them easy to read and maintain.

In the previous slide we extended a basic nginx container with some content, 
lets look at extending that with the builder pattern.

The [Dockerfile](./Dockerfile) we will be using is in the root of this project.
In order to see how this container is built, lets take a look at

Now we can build the image with:

- Build Image: `docker build -t nginx:docker-for-devs-builder-pattern .`
- Run Container: `docker run --name nginx-builder-pattern -d -p 8080:80 nginx:docker-for-devs-builder-pattern`
- Check at: http://localhost:8080/

## Other Optimisations ##

In my previous employment, the system contained over 10 in-house micro-services
for the basic system. We found it was significantly easier to create builder
images once and push them to a docker repository, and then simply pull them
in and run the commands. In this example there would be no need to do the apt-get
commands, making reading the Dockerfile significantly easier. In fact, all images
were based on private repositories for auditability.

## Clean up ##

Cleaning up with:

- `docker stop nginx-builder-pattern ` to stop the running container.
- `docker rm nginx-builder-pattern ` to remove the running container.
- `docker rmi nginx:docker-for-devs-builder-pattern` to remove the underlying image.

## Next steps ##

```bash
git checkout slide-5
```

## More information ##

You can also get more info directly from their getting started guide at https://docs.docker.com/get-started/
