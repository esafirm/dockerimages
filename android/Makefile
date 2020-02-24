.DEFAULT_GOAL:=build
.PHONY=build push run create

SHELL:=/usr/bin/env bash

NAME:=esafirm/android
tag ?= latest

build: 
	docker build -t $(NAME):$(tag) .

push:
	docker push $(NAME):$(tag)

create: build push

run:
	docker run -it $(NAME):$(tag) bash

run_temp:
	docker build --no-cache -t $(NAME):temp . && docker run -it $(NAME) /bin/bash

