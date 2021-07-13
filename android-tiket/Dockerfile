FROM esafirm/android:latest

# Install Git for versioning
RUN apk --no-cache add git python3 rsync

# Copy fireup binary
COPY ./bin/fireup /usr/bin/fireup

WORKDIR /home/android