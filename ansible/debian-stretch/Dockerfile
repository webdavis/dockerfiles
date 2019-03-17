# This Dockerfile bootstraps a Debian Stretch environment with Ansible.
# Site: https://www.ansible.com
#
# Run the following commands in the folder where the Dockerfile is contained.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/ansible:debian-stretch .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
#           --hostname debian \
#           --name ansible_debian_stretch \
#           webdavis/ansible:debian-stretch
#
# Enter container:
#
#   $ sudo docker exec -ti ansible_debian_stretch /bin/bash -l
#
FROM webdavis/debian:stretch-systemd
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

# Pip packages.
ENV PIP_PACKAGES "PyYAML==3.13 ansible molecule"

# The build dependencies are removed after Ansbile installation.
ADD https://bootstrap.pypa.io/get-pip.py /
RUN builddeps=' \
                python-dev \
                gcc \
                make \
                ' \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
                python \
                sudo \
                ca-certificates \
                $builddeps \
    && python get-pip.py \
    && pip install --upgrade pip \
    && pip install $PIP_PACKAGES \
    && mkdir -p /etc/ansible \
    && echo "[local]\\nlocalhost ansible_connection=local" > /etc/ansible/hosts \
    && find / -name '*.pyc' -delete; \
    find / -name '*__pycache__*' -delete; \
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

CMD ["/lib/systemd/systemd"]
