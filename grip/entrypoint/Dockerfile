# https://github.com/joeyespo/grip
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/grip:entrypoint .
#
# Run container:
#
#   $ sudo docker run -ti \
#           --rm \
#           --volume=${HOME}/.grip:/root/.grip:ro \
#           --volume=${PWD}:/root \
#           -p 6419:6419 \
#           --name grip \
#           webdavis/grip:entrypoint \
#           README.md 0.0.0.0:6419
#
FROM alpine:latest
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

ADD https://bootstrap.pypa.io/get-pip.py /
RUN builddeps=' \
	    python3-dev \
	    gcc \
	    make \
	    ' \
    && apk add --no-cache \
	    python3 \
	    $builddeps \
    && python3 get-pip.py \
    && pip install --upgrade pip \
    && pip install grip \
    && apk del --purge $builddeps \
    && rm get-pip.py; \
    find / -name '*.pyc' -delete; \
    find / -name '*__pycache__*' -delete

WORKDIR /root
EXPOSE 6419
ENTRYPOINT ["grip"]
