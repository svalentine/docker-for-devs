# Checking your install #

## First, some concepts ##

### What is an image? ###

An image is an executable package that includes everything needed to run an application - the code, a runtime, libraries, environment variables, and configuration files.

### What is a container? ###

A container is a runtime instance of an image - what the image becomes in memory when executed (that is, an image with state, or a user process).

## Getting Started ##

Lets check out initial install: 

```bash
docker run hello-world:latest
```

You should get some output sent to your terminal
```
unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
d1725b59e92d: Pull complete
Digest: sha256:0add3ace90ecb4adbf7777e9aacf18357296e799f81cabc9fde470971e499788
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
...
```

As you can see, docker downloaded the image from docker hub (more on this later), and ran it.

## Next steps ##

```bash
git checkout slide-2
```

## More information ##

You can also get more info directly from their getting started guide at https://docs.docker.com/get-started/
