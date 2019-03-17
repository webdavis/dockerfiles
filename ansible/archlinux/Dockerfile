# This Dockerfile bootstraps an Arch Linux environment with Ansible.
# Site: https://www.ansible.com
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/ansible:archlinux .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --privileged \
#           --tmpfs /run \
#           --tmpfs /run/lock \
#           --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
#           --hostname archlinux \
#           --name ansible_archlinux \
#           webdavis/ansible:archlinux
#
# Enter container:
#
#   $ sudo docker exec -ti ansible_archlinux /bin/bash -l
#
FROM webdavis/archlinux:systemd
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

# Pip packages.
ENV PIP_PACKAGES "PyYAML==3.13 ansible molecule"

# Install dependencies.
ADD https://bootstrap.pypa.io/get-pip.py /
RUN builddeps=' \
		gcc \
		make \
		' \
    && pacman -Syu --noconfirm \
		python \
		sudo \
		$builddeps \
    && python get-pip.py \
    && pip install --upgrade pip \
    && pip install $PIP_PACKAGES \
    && mkdir -p /etc/ansible \
    && echo "[local]\\nlocalhost ansible_connection=local" > /etc/ansible/hosts \
    && find / -name '*.pyc' -delete; \
    find / -name '*__pycache__*' -delete; \
    rm -f ./get-pip.py; \
    rm -rf /usr/share/doc; \
    rm -rf /usr/share/man; \
    rm -rf /tmp/*; \
    pacman --remove --nosave --unneeded $builddeps; \
    pacman --sync --clean --clean --noconfirm

# Create a user account, and enable passwordless `sudo`.
RUN useradd --create-home localuser \
    && echo 'localuser:localuser' | chpasswd \
    && echo 'localuser ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/localuser \
    && chmod 440 /etc/sudoers.d/localuser

CMD ["/usr/sbin/init"]
