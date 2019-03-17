# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/alpine:runit
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --hostname alpine \
#           --name alpine_runit \
#           webdavis/alpine:runit
#
# Enter container:
#
#   $ sudo docker exec -ti alpine_runit /init /bin/sh -l
#
FROM alpine:latest

RUN apk update --no-cache \
    && apk upgrade --no-cache \
    && apk add --no-cache --no-progress \
	ca-certificates \
	syslog-ng \
	runit \
	--repository http://dl-cdn.alpinelinux.org/alpine/edge/main

COPY service /etc/service
COPY runit_bootstrap /usr/sbin/runit_bootstrap
RUN cp /etc/syslog-ng/syslog-ng.conf /etc/syslog-ng/syslog-ng.conf.backup
COPY syslog-ng.conf /etc/syslog-ng/syslog-ng.conf

STOPSIGNAL SIGKILL

CMD ["/usr/sbin/runit_bootstrap"]
