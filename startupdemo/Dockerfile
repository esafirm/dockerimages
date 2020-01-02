FROM alpine:3.11.2

## Install bash plz
RUN apk add --no-cache bash

RUN echo "Hello RUN" >> hello
CMD echo "Hello CMD" >> hello

COPY entrypoint.sh bin/entrypoint.sh

ENTRYPOINT [ "entrypoint.sh" ]