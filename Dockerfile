FROM alpine:3.12

WORKDIR /app

COPY build.sh /app

RUN /app/build.sh

RUN tsschecker --help
