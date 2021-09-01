FROM adoptopenjdk/openjdk11-openj9:jdk-11.0.12_7_openj9-0.27.0-alpine
LABEL maintainer="Esa Firman"
LABEL description="Android SDK 30"

ENV ANDROID_HOME "/opt/android-sdk-linux"
ENV PATH=$PATH:$ANDROID_HOME/platform-tools
ENV PATH=$PATH:$ANDROID_HOME/build-tools/$BUILD_TOOLS
ENV PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

ARG CMD_TOOLS="7583922"
ARG BUILD_TOOLS="30.0.3"
ARG TARGET_SDK="30"

ARG CMD_TOOLS_ZIP="/tmp/cmdlinetools.zip"
ARG CMD_TOOLS_DIR="${ANDROID_HOME}/cmdline-tools/latest/"

# Download and extract Android Tools
RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-${CMD_TOOLS}_latest.zip -O ${CMD_TOOLS_ZIP} && \
    unzip -qq ${CMD_TOOLS_ZIP} -d /tmp/ && \
    mkdir -p ${CMD_TOOLS_DIR}} && \
    mv /tmp/cmdline-tools/* ${CMD_TOOLS_DIR} && \
    rm -v ${CMD_TOOLS_ZIP}

# Install SDK Packages
RUN mkdir -p ~/.android/ && touch ~/.android/repositories.cfg && \
    yes | sdkmanager "--licenses" && \
    sdkmanager "--update" && \
    sdkmanager "platform-tools" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;instantapps"

# # Install SDK Packages
RUN yes | sdkmanager \
    "build-tools;${BUILD_TOOLS}" \
    "platforms;android-${TARGET_SDK}" && \
    rm -rf /tmp/PackageOperation*

# Install Bash for Gradlew
RUN apk --no-cache add bash

WORKDIR /home/android