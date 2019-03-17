# Archlinux intermediary image.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/archlinux:latest .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --init \
#           --hostname archlinux \
#           --name archlinux \
#           webdavis/archlinux:latest
#
# Enter container:
#
#   $ sudo docker exec -ti archlinux /bin/bash -l
#
FROM archlinux/base:latest
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

RUN pacman -Syu --noconfirm \
    && pacman --sync --clean --clean --noconfirm
