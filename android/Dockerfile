# extract libgcc_s from the same base image than the one used to build glibc (see https://github.com/sgerrand/docker-glibc-builder/blob/master/Dockerfile)
ARG alpine_pkg_glibc_image=ubuntu:18.04

FROM ${alpine_pkg_glibc_image} as libgcc
RUN chmod +x /lib/x86_64-linux-gnu/libz.so.1.2.11

FROM openjdk:8-alpine
LABEL maintainer="Esa Firman"
LABEL description="Android SDK 30"

ARG SDK_TOOLS="4333796"
ARG GLIBC_VERSION="2.32-r0"
ARG BUILD_TOOLS="30.0.3"
ARG TARGET_SDK="30"

ENV ANDROID_HOME "/opt/android-sdk-linux"
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
ENV PATH=$PATH:$ANDROID_HOME/build-tools/$BUILD_TOOLS

# Add the extra libs
COPY --from=libgcc /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libz.so.1.2.11 /usr/glibc-compat/lib/

## Install GLIBC
ENV GLIBC_VERSION=${GLIBC_VERSION}
RUN apk --no-cache add openssl curl \
    && curl -s https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk -o glibc.apk \
    && curl -sL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk -o glibc-bin.apk \
    && curl -sL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk -o glibc-i18n.apk \
    && apk --no-cache add glibc-bin.apk glibc.apk glibc-i18n.apk \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf glibc.apk glibc-bin.apk glibc-i18n.apk

# Download and extract Android Tools
RUN wget -q http://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS}.zip -O /tmp/tools.zip && \
    mkdir -p ${ANDROID_HOME} && \
    unzip -qq /tmp/tools.zip -d ${ANDROID_HOME} && \
    rm -v /tmp/tools.zip

# Install SDK Packages
RUN mkdir -p ~/.android/ && touch ~/.android/repositories.cfg && \
    yes | sdkmanager "--licenses" && \
    sdkmanager "--update" && \
    sdkmanager "platform-tools" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;instantapps"

# Install SDK Packages
RUN yes | sdkmanager \
    "build-tools;${BUILD_TOOLS}" \
    "platforms;android-${TARGET_SDK}" && \
    rm -rf /tmp/PackageOperation*

# Install Bash for Gradlew
RUN apk --no-cache add bash

WORKDIR /home/android