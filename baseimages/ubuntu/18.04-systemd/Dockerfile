# This Dockerfile configures an Ubuntu 18.04 LTS environment with systemd.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/ubuntu:18.04-systemd
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --tmpfs /run \
#           --tmpfs /run/lock \
#           --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
#           --hostname ubuntu \
#           --name ubuntu_18.04_systemd \
#           webdavis/ubuntu:18.04-systemd
#
# Enter container:
#
#   $ sudo docker exec -ti ubuntu_18.04_systemd /bin/bash -l
#
FROM ubuntu:18.04
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"
ENV container docker

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    	systemd \
	systemd-sysv \
    && apt-get autoremove -y; apt-get clean

RUN find /etc/systemd/system \
        /lib/systemd/system \
        -path '*.wants/*' \
        -not -name '*journald*' \
        -not -name '*systemd-tmpfiles*' \
        -not -name '*systemd-user-sessions*' \
        -exec rm \{} \;
RUN systemctl set-default multi-user.target
STOPSIGNAL SIGRTMIN+3

# Reserve this folder for the host volume.
VOLUME ["/sys/fs/cgroup"]

CMD ["/sbin/init"]
