# This Dockerfile bootstraps a CentOS 7 environment with Ansible.
# Site: https://www.ansible.com
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/ansible:centos-7 .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --tmpfs /run \
#           --tmpfs /run/lock \
#           --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
#           --hostname centos \
#           --name ansible_centos_7 \
#           webdavis/ansible:centos-7
#
# Enter container:
#
#   $ sudo docker exec -ti ansible_centos_7 /bin/bash -l
#
FROM webdavis/centos:7-systemd
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

# Pip packages.
ENV PIP_PACKAGES "PyYAML==3.13 ansible molecule"

# Install dependencies.
ADD https://bootstrap.pypa.io/get-pip.py /
RUN builddeps=' \
                python36u-devel \
                gcc \
                make \
                ' \
    && yum update -y \
    && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && yum install -y \
		$builddeps \
		python36u \
		sudo \
    && python3.6 get-pip.py \
    && pip3 install --upgrade pip \
    && pip3 install $PIP_PACKAGES \
    && mkdir -p /etc/ansible \
    && echo -e "[local]\\nlocalhost ansible_connection=local" > /etc/ansible/hosts \
    && find / -name '*.pyc' -delete; \
    find / -name '*__pycache__*' -delete; \
    rm -rf /usr/share/doc; \
    rm -rf /usr/share/man; \
    rm -rf /tmp/* \
    && yum remove -y $builddeps \
    && yum autoremove -y; yum clean all

# See: https://unix.stackexchange.com/questions/122616
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/' /etc/sudoers

# Create a user account, and enable passwordless `sudo`.
RUN useradd --create-home localuser \
    && echo 'localuser:localuser' | chpasswd \
    && echo 'localuser ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/localuser \
    && chmod 440 /etc/sudoers.d/localuser

CMD ["/sbin/init"]
