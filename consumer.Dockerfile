FROM golang:1.11 AS builder

# @todo: Figure out how to turn this on
ENV GO111MODULE=off
ENV CGO_ENABLED=0
ENV GOOS=linux

COPY --chown=0:0 consumer ./src/github.com/svalentine/docker-for-devs

#
# Build the binaries.
# The individial go get's and version specific stuff I can't seem to get to work.
# it seems that the library portion of the app dissapears
#
RUN set -ex ; \
    go get -d -v ./... ; \
    go build -a -installsuffix nocgo -o /app/consumer ./src/github.com/svalentine/docker-for-devs/main.go

FROM scratch

COPY --from=builder /app /app

WORKDIR /app
ENTRYPOINT [ "/app/consumer" ]
