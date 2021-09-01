FROM adoptopenjdk/openjdk8-openj9:jdk8u292-b10_openj9-0.26.0-alpine
LABEL maintainer="Esa Firman"
LABEL description="Android SDK 30"

ARG SDK_TOOLS="4333796"
ARG BUILD_TOOLS="30.0.3"
ARG TARGET_SDK="30"

ENV ANDROID_HOME "/opt/android-sdk-linux"
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
ENV PATH=$PATH:$ANDROID_HOME/build-tools/$BUILD_TOOLS

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