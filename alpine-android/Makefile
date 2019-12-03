.DEFAULT_GOAL:=build
.PHONY=build push run

SHELL:=/usr/bin/env bash

tag ?= latest

build: 
	docker build -t esafirm/alpine-android:$(tag) .

push:
	docker push esafirm/alpine-android:$(tag)

run:
	docker build -t esafirm/temp . && docker run -it -e DBX_AUTH_TOKEN=$DBX_AUTH_TOKEN esafirm/temp /bin/bash

