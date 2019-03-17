# Alpine intermediary image.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/alpine:latest .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --init \
#           --hostname alpine \
#           --name alpine \
#           webdavis/alpine:latest
#
# Enter container:
#
#   $ sudo docker exec -ti alpine /bin/sh -l
#
FROM alpine:latest
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

RUN apk --no-cache update \
    && apk --no-cache upgrade
