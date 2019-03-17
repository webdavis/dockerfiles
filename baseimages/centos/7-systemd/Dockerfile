# This Dockerfile configures a CentOS 7 environment with systemd.
#
# Create image:
#
#   $ sudo docker build \
#           --tag webdavis/centos:7-systemd .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --tmpfs /run \
#           --tmpfs /run/lock \
#           --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
#           --hostname centos \
#           --name centos_7_systemd \
#           webdavis/centos:7-systemd
#
# Enter container:
#
#   $ sudo docker exec -ti centos_7_systemd /bin/bash -l
#
FROM centos:7
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"
ENV container docker

RUN yum update -y \
    && yum upgrade -y; \
    yum autoremove -y; \
    yum clean all

RUN find /etc/systemd/system \
        /lib/systemd/system \
        -path '*.wants/*' \
        -not -name '*journald*' \
        -not -name '*systemd-tmpfiles*' \
        -not -name '*systemd-user-sessions*' \
        -exec rm \{} \;
RUN systemctl set-default multi-user.target \
    && systemctl enable systemd-user-sessions.service
STOPSIGNAL SIGRTMIN+3

# Reserve this folder for the host volume.
VOLUME ["/sys/fs/cgroup"]

CMD ["/sbin/init"]
