DEFAULT_GOAL := dev
.PHONY: up dev secure image log tail-log ps start stop clean bash bash-root test-dev test-secure upload-image
#
# If there is an environment variable to tag, use it, otherwise detect from
# the git repo.
# To manually supply one you can do something like IMAGE_TAG=foo make ...
#
ifeq ($(IMAGE_TAG),)
    # Increment this number on each push and commit this file
    export IMAGE_TAG=1.0.1
	# You can also drive the image tag from the git branch/tag with something like
	# export IMAGE_TAG=$(shell git symbolic-ref --short HEAD | sed 's/[^a-zA-Z0-9_.-]/_/g')
endif

export IMAGE_REPO=123456789.dkr.ecr.eu-west-2.amazonaws.com/something
PROJECT_NAME=docker-for-devs
BUILD_OPS=--no-cache

up:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml -f docker-compose-secure.yml up -d

dev:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml -f docker-compose-dev.yml up -d

secure:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml -f docker-compose-dev.yml up -d

image:
	docker build $(BUILD_OPS) -t $(IMAGE_REPO)/$(PROJECT_NAME):$(IMAGE_TAG) -f Dockerfile .

image-consumer:
	docker build $(BUILD_OPS) -t $(IMAGE_REPO)/$(PROJECT_NAME)_consumer:$(IMAGE_TAG) -f consumer.Dockerfile .

image-apache:
	docker build $(BUILD_OPS) -t $(IMAGE_REPO)/$(PROJECT_NAME)_apache:$(IMAGE_TAG) -f apache.Dockerfile .


log:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml logs

tail-log:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml logs -f

ps:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml ps

start:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml start

stop:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml stop

clean: stop
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml down

bash:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml exec --user ww-data apache bash

bash-root:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml exec --user root apache bash

test-dev:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml -f docker-compose-dev.yml config

test-secure:
	docker-compose -p $(PROJECT_NAME) -f docker-compose.yml -f docker-compose-secure.yml config

upload-image: image
#	aws ecr get-login ......
#	docker push $(IMAGE_REPO)/$(PROJECT_NAME):$(IMAGE_TAG)
