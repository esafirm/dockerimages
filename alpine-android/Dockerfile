FROM fadeltd/alpine-android-ndk

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
ENV FASTLANE_VERSION=2.138.0
RUN gem install fastlane -N -v $FASTLANE_VERSION    

## Resolve Jenkins issue https://github.com/gradle/gradle/issues/3117
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV GLIBC_VERSION "2.28-r0"
RUN curl -s https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk -o glibc.apk \
    && curl -sL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk -o glibc-bin.apk \
    && curl -sL https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk -o glibc-i18n.apk \
    && apk add glibc-bin.apk glibc.apk glibc-i18n.apk \
    && /usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8 \
    && rm -rf glibc.apk glibc-bin.apk glibc-i18n.apk

## Generating debug.keystore
RUN keytool -genkey -v -keystore ~/.android/debug.keystore -alias androiddebugkey \
    -storepass android -keypass android -keyalg RSA -keysize 2048 -validity 10000 -dname "CN=Android Debug,O=Android,C=US" 

WORKDIR /home/android

## Add required bins
ADD bin/linux/ /bin/
ADD init.sh /bin/init.sh
ADD entrypoint.sh /bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

