# https://www.ansible.com
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/ansible:ansible-container .
#
# Run container:
#
# > Note: make sure the --volume flag mounts the correct pathes to your ansible config
# >       files on your host os.
#
#   $ sudo docker run -t \
#           --rm \
# 	    --volume ${PWD}/hosts:/etc/ansible/hosts \
# 	    --volume ${PWD}/ansible.cfg:/etc/ansible/ansible.cfg \
# 	    --volume ${HOME}/.ssh:/root/.ssh:ro \
#	    webdavis/ansible:ansible-container \
# 	    ansible-container init
#
FROM alpine:latest
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

ADD https://bootstrap.pypa.io/get-pip.py /
RUN builddeps=' \
            python-dev \
            musl-dev \
            gcc \
            git \
            ' \
    && apk add --no-cache \
            python \
            py-setuptools \
            ca-certificates \
            $builddeps \
    && python get-pip.py \
    && pip install --upgrade pip \
    && git clone https://github.com/ansible/ansible-container.git \
    && pip install \
            'websocket-client<=0.40.0' \
            colorama \
    && pip install -e ansible-container[docker,k8s,openshift] \
    && apk del --purge $builddeps \
    && rm -rf get-pip.py; \
    find / -name '*.pyc' -delete; \
    find / -name '*__pycache__*' -delete; \
    find / -type d -name '.git/*' -exec rm -rf \{} \;

ENTRYPOINT ["ansible-container"]
