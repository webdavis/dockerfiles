# This Dockerfile configures a Debian Stretch environment with systemd.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/debian:stretch-systemd
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
#           --hostname debian \
#           --name debian_stretch_systemd \
#           webdavis/debian:stretch-systemd
#
# Enter container:
#
#   $ sudo docker exec -ti debian_stretch_systemd /bin/bash -l
#
FROM debian:stretch
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"
ENV container docker

# Add the following repos:
# - contrib
# - non-free
# - backports
ADD sources.list /etc/apt/sources.list

# Pin stable repositories.
ADD preferences /etc/apt/preferences

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    	systemd \
	apt-utils \
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

# Reserve these folders for the volume mounts.
VOLUME [ "/sys/fs/cgroup", "/run", "/run/lock", "/tmp" ]

CMD ["/lib/systemd/systemd"]
