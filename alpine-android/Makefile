.DEFAULT_GOAL:=build
.PHONY=build push run create

SHELL:=/usr/bin/env bash

tag ?= latest

build: 
	docker build -t esafirm/alpine-android:$(tag) .

push:
	docker push esafirm/alpine-android:$(tag)

create: build push

run:
	docker run -it esafirm/alpine-android:$(tag) bash

run_temp:
	docker build -t esafirm/temp . && docker run -it -e DBX_AUTH_TOKEN=${DBX_AUTH_TOKEN} esafirm/temp /bin/bash

