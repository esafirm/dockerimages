FROM esafirm/android

LABEL maintainer="BL"

RUN apk --no-cache add openssl git curl \
    && curl -sLO https://github.com/github/git-lfs/releases/download/v2.0.1/git-lfs-linux-amd64-2.0.1.tar.gz \
    && tar zxvf git-lfs-linux-amd64-2.0.1.tar.gz \
    && mv git-lfs-2.0.1/git-lfs /usr/bin/ \
    && rm -rf git-lfs-2.0.1 \
    && rm -rf git-lfs-linux-amd64-2.0.1.tar.gz

## Deps
RUN apk --no-cache add --update \
    ca-certificates \
    wget \
    unzip \
    zip \
    libstdc++ \
    g++ \
    make \
    ruby \
    ruby-irb \
    ruby-dev \
    bc \
    coreutils

## Firebase
RUN curl -Lo ./firebase https://firebase.tools/bin/linux/latest \
    && chmod +xr firebase \
    && mv firebase /bin/firebase

## Fastlane
ENV FASTLANE_VERSION=2.140.0
RUN apk --no-cache add --update curl-dev imagemagick \
    && gem install fastlane -N -v $FASTLANE_VERSION \
    && gem install badge; exit 0;

## Setup bundler to right version
RUN yes | gem uninstall bundler --force \
    && gem install bundler --version='1.17.3'; exit 0

## Resolve Jenkins issue https://github.com/gradle/gradle/issues/3117
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

## Generating debug.keystore
RUN keytool -genkey -v -keystore ~/.android/debug.keystore -alias androiddebugkey \
    -storepass android -keypass android -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=Android Debug,O=Android,C=US" 

## Add bash
RUN apk --no-cache add bash

WORKDIR /home/android

## Add required bins
ADD bin/linux/ /bin/
ADD init.sh /bin/init.sh
ADD entrypoint.sh /bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

