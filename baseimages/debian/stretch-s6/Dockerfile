# Runs s6 as PID 1. See:
# https://github.com/just-containers/s6-overlay
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/debian:stretch-s6
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --hostname debian \
#           --name debian_stretch_s6 \
#           webdavis/debian:stretch-s6
#
# Enter container:
#
#   $ sudo docker exec -ti debian_stretch_s6 /init /bin/bash -l
#
FROM debian:stretch
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

ENV S6_OVERLAY_VERSION v1.21.8.0
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get autoremove -y; apt-get clean \
    && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

COPY . /

ENTRYPOINT ["/init"]
