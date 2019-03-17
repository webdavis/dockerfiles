# This Dockerfile bootstraps an Ubuntu 18.04 LTS environment with Ansible.
# Site: https://www.ansible.com
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/ansible:ubuntu-18.04 .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --tmpfs /run \
#           --tmpfs /run/lock \
#           --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
#           --hostname ubuntu \
#           --name ansible_ubuntu_18.04 \
#           webdavis/ansible:ubuntu-18.04
#
# Enter container:
#
#   $ sudo docker exec -ti ansible_ubuntu_18.04 /bin/bash -l
#
FROM webdavis/ubuntu:18.04-systemd
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

# Pip packages.
ENV PIP_PACKAGES "PyYAML==3.13 ansible molecule"

# Install dependencies.
ADD https://bootstrap.pypa.io/get-pip.py /
RUN builddeps=' \
		python3-dev \
		gcc \
		make \
		' \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
		python3 \
		sudo \
		ca-certificates \
		$builddeps \
    && python3 get-pip.py \
    && pip3 install --upgrade pip \
    && pip3 install $PIP_PACKAGES \
    && mkdir -p /etc/ansible \
    && echo "[local]\\nlocalhost ansible_connection=local ansible_python_interpreter=$(which python3)" > /etc/ansible/hosts \
    && find / -name '*.pyc' -delete; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /usr/share/doc; \
    rm -rf /usr/share/man; \
    rm -rf /tmp/*; \
    apt-get remove -y $builddeps; apt-get autoremove -y; apt-get clean

# Create a user account, and enable passwordless `sudo`.
RUN useradd --create-home localuser \
    && echo 'localuser:localuser' | chpasswd \
    && echo 'localuser ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/localuser \
    && chmod 440 /etc/sudoers.d/localuser

CMD ["/sbin/init"]
