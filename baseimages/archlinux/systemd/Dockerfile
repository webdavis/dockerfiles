# This Dockerfile configures an Archlinux environment with systemd.
#
# Create image:
#
#   $ sudo docker build \
#           --tag webdavis/archlinux:systemd .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --privileged \
#           --tmpfs /run \
#           --tmpfs /run/lock \
#           --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
#           --hostname archlinux \
#           --name archlinux_systemd \
#           webdavis/archlinux:systemd
#
# Enter container:
#
#   $ sudo docker exec -ti archlinux_systemd /bin/bash -l
#
FROM archlinux/base:latest
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"
ENV container docker

# systemd-sysvcompat provides the `/usr/sbin/init` executable.
RUN pacman -Syu --noconfirm systemd-sysvcompat \
    && pacman --sync --clean --clean --noconfirm

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

CMD ["/usr/sbin/init"]
