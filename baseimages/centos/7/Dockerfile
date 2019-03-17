# Centos 7 intermediary image.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/centos:7 .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --init \
#           --hostname centos \
#           --name centos_7 \
#           webdavis/centos:7
#
# Enter container:
#
#   $ sudo docker exec -ti centos_7 /bin/bash -l
#
FROM centos:7
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

RUN yum update -y \
    && yum upgrade -y \
    && yum autoremove -y; yum clean all
