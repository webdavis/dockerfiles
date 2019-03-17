# Runs s6 as PID 1. See:
# https://github.com/just-containers/s6-overlay
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/alpine:s6
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --hostname alpine \
#           --name alpine_s6 \
#           webdavis/alpine:s6
#
# Enter container:
#
#   $ sudo docker exec -ti alpine_s6 /init /bin/sh -l
#
FROM alpine:latest
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

ENV S6_OVERLAY_VERSION v1.21.8.0
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/

RUN apk --no-cache update \
    && apk --no-cache upgrade \
    && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

COPY . /

ENTRYPOINT ["/init"]
