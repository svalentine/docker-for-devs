# Some basic commands #

## docker ps ##
Lets find the container:

```bash
docker ps 
```

You will notice that there is no output for the hello-world application earlier. That is because docker ps only shows _running_ containers. 

Let us instead try

```bash
docker ps -a
```

You should have output similar to:

```
CONTAINER ID     IMAGE                COMMAND   CREATED             STATUS                         PORTS  NAMES
8685dc4f77e7    hello-world:latest   "/hello"  About an hour ago   Exited (0) About an hour ago           adoring_jang
```

## docker images ##
Now that we have run something with docker, lets take a look at our status.
If you already have have other images + containers then your output may look different.

Lets find the image:
```bash
docker images
```

Your output should contain
```
REPOSITORY        TAG       IMAGE ID      CREATED       SIZE
hello-world       latest    4ab4c602aa5e  3 months ago  1.84kB
....
```

This is the basic image that you ran in step 1.

## Next steps ##

```bash
git checkout slide-3
```

## More information ##

You can also get more info directly from their getting started guide at https://docs.docker.com/get-started/
