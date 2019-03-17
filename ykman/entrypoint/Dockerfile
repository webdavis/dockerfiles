# https://github.com/Yubico/yubikey-manager
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/ykman:entrypoint .
#
# Run container:
#
#   $ sudo docker run -ti \
#           --rm \
#           --device /dev/bus/usb \
#           --device /dev/usb \
#           --name ykpersonalize \
#           webdavis/ykman:entrypoint
#
FROM alpine:latest
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

ADD https://bootstrap.pypa.io/get-pip.py /
RUN builddeps=' \
	    python-dev \
	    py-setuptools \
	    musl-dev \
	    openssl-dev \
	    libffi-dev \
	    gcc \
	    make \
	    ' \
    && apk add --no-cache \
	    libusb \
	    swig \
	    pcsc-lite-dev \
	    ccid \
	    python \
	    ykpers-dev \
	    $builddeps \
    && python get-pip.py \
    && pip install --upgrade pip \
    && pip install \
	    pyscard \
	    yubikey-manager \
    && apk del --purge $builddeps \
    && rm get-pip.py; \
    find / -name '*.pyc' -delete; \
    find / -name '*__pycache__*' -delete

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["ykman", "--help"]
