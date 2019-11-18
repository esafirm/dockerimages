.DEFAULT_GOAL:=build
.PHONY=build push

SHELL:=/usr/bin/env bash

tag ?= latest

build: 
	docker build -t esafirm/alpine-android:$(tag) .

push:
	docker push esafirm/alpine-android:$(tag)


