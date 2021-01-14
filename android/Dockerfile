ARG alpine_version=3.10.1
ARG alpine_glibc_version=2.29-r0

# extract libgcc_s from the same base image than the one used to build glibc (see https://github.com/sgerrand/docker-glibc-builder/blob/master/Dockerfile)
ARG alpine_pkg_glibc_image=ubuntu:18.04

FROM ${alpine_pkg_glibc_image} as libgcc
RUN chmod +x /lib/x86_64-linux-gnu/libz.so.1.2.11

FROM esafirm/android-base:latest
LABEL maintainer="Bukalapak"
LABEL description="Android SDK 29 & NDK"

ARG SDK_TOOLS="4333796"
ARG GLIBC_VERSION="2.29-r0"
ARG BUILD_TOOLS="29.0.2"
ARG TARGET_SDK="29"
ARG CMAKE_VERSION="3.6.4111459"

ENV ANDROID_HOME "/opt/android-sdk-linux"
ENV NDK_HOME $ANDROID_HOME/ndk-bundle
ENV PATH=$PATH:$ANDROID_HOME/cmake/3.6.4111459/bin/:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
ENV PATH=$PATH:$ANDROID_HOME/build-tools/$BUILD_TOOLS

# Add the extra libs
COPY --from=libgcc /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libz.so.1.2.11 /usr/glibc-compat/lib/

## Install GLIBC
ENV GLIBC_VERSION="2.29-r0"
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
        "platforms;android-${TARGET_SDK}"

# Install NDK & CMAKE Packages
RUN yes | sdkmanager \
        "cmake;${CMAKE_VERSION}" \
        "ndk-bundle" >/dev/null

# Delete unnecessary NDK Packages
RUN rm -rf  \
        # Delete simpleperf tool
        $NDK_HOME/simpleperf \
        # Delete STL version we don't care about
        $NDK_HOME/sources/cxx-stl/stlport \
        $NDK_HOME/sources/cxx-stl/gnu-libstdc++ \
        # Delete unused prebuild images
        $NDK_HOME/prebuilt/android-mips* \
        # Delete obsolete Android platforms
        $NDK_HOME/platforms/android-9 \
        $NDK_HOME/platforms/android-12 \
        $NDK_HOME/platforms/android-13 \
        $NDK_HOME/platforms/android-15 \
        $NDK_HOME/platforms/android-16 \
        # Delete unused platform sources
        $NDK_HOME/sources/cxx-stl/gnu-libstdc++/4.9/libs/mips* \
        $NDK_HOME/sources/cxx-stl/llvm-libc++/libs/mips* \
        # Delete LLVM STL tests
        $NDK_HOME/sources/cxx-stl/llvm-libc++/test \
        # Delete unused toolchains
        $NDK_HOME/toolchains/mips \
        $NDK_HOME/build/core/toolchains/mips* \
    && sdkmanager --list | sed -e '/Available Packages/q'

WORKDIR /home/android