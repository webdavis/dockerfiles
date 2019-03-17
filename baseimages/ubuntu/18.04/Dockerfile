# Ubuntu 18.04 LTS intermediary image.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/ubuntu:18.04
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --init \
#           --hostname ubuntu \
#           --name ubuntu_18.04 \
#           webdavis/ubuntu:18.04
#
# Enter container:
#
#   $ sudo docker exec -ti ubuntu_18.04 /bin/bash -l
#
FROM ubuntu:18.04
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get autoremove -y; apt-get clean
