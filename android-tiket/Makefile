.DEFAULT_GOAL:=build
.PHONY=build push run create

SHELL:=/usr/bin/env bash

NAME:=esafirm/android-tiket
tag ?= latest
dir ?= ${pwd}

help:	## Show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

build:	## Build the docker image. Accept $tag
	docker build -t $(NAME):$(tag) .

push:	## Push the docker image to docker hub. Accept $tag
	docker push $(NAME):$(tag)

create: ## Build and push the image
	build push

run:	## Run the image. Accept $dir and $tag
	docker run -it -v $(dir):/home/android $(NAME):$(tag) bash

run_temp:	## Build and run the image
	docker build --no-cache -t $(NAME):temp . && docker run -it $(NAME) /bin/bash
