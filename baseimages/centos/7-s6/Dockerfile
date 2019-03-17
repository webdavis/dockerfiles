# Runs s6 as PID 1. See:
# https://github.com/just-containers/s6-overlay
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/centos:7-s6
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --hostname centos \
#           --name centos_7_s6 \
#           webdavis/centos:7-s6
#
# Enter container:
#
#   $ sudo docker exec -ti centos_7_s6 /init /bin/bash -l
#
FROM centos:7
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/

RUN yum update -y \
    && yum upgrade -y \
    && yum autoremove -y; yum clean all \
    && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude="./bin" \
    && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin

COPY . /

ENTRYPOINT ["/init"]
