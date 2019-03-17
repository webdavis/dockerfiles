# Debian Stretch intermediary image.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/debian:stretch
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --init \
#           --hostname debian \
#           --name debian_stretch \
#           webdavis/debian:stretch
#
# Enter container:
#
#   $ sudo docker exec -ti debian_stretch /bin/bash -l
#
FROM debian:stretch
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get autoremove -y; apt-get clean
