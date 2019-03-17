# Runs s6 as PID 1. See:
# https://github.com/just-containers/s6-overlay
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/archlinux:s6 .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --hostname archlinux \
#           --name archlinux_s6 \
#           webdavis/archlinux:s6
#
# Enter container:
#
#   $ sudo docker exec -ti archlinux_s6 /init /bin/bash -l
#
FROM archlinux/base:latest
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/

RUN pacman -Syu --noconfirm tar \
    && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" \
    && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin \
    && pacman --remove --nosave --unneeded --noconfirm tar \
    && pacman --sync --clean --clean --noconfirm

COPY . /

ENTRYPOINT ["/init"]
