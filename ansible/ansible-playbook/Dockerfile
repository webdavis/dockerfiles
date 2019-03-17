# https://www.ansible.com
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/ansible:ansible-playbook .
#
# Run container:
#
# Note: make sure the --volume flag mounts the correct pathes to your ansible config
#	files on your host os.
#
#   $ sudo docker run --rm -ti \
# 	    --volume ${PWD}/hosts:/etc/ansible/hosts \
# 	    --volume ${PWD}/ansible.cfg:/etc/ansible/ansible.cfg \
# 	    --volume ${HOME}/.ssh:/root/.ssh:ro \
#	    webdavis/ansible:ansible-playbook \
# 	    ansible-playbook all -m ping
#
FROM alpine:latest
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

ADD https://bootstrap.pypa.io/get-pip.py /
RUN builddeps=' \
	    python3-dev \
	    musl-dev \
	    openssl-dev \
	    libffi-dev \
	    gcc \
	    make \
	    ' \
    && apk update --no-cache \
    && apk add --no-cache \
	    python3 \
	    ca-certificates \
	    $builddeps \
    && python3 get-pip.py \
    && pip install --upgrade pip \
    && pip install \
	    httplib2 \
	    ansible \
    && apk del --purge $builddeps \
    && rm get-pip.py; \
    find / -name '*.pyc' -delete; \
    find / -name '*__pycache__*' -delete

ENTRYPOINT ["ansible-playbook"]
