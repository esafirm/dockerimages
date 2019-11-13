.DEFAULT_GOAL:=build
.PHONY=build push

SHELL:=/usr/bin/env bash

build: 
	docker build -t esafirm/alpine-android .

push:
	docker push esafirm/alpine-android:latest


