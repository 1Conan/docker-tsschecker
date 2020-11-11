FROM alpine:edge

WORKDIR /app

COPY build.sh /app

RUN /app/build.sh

RUN rm /app/build.sh

RUN tsschecker --help
