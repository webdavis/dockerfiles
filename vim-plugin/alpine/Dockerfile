# This Dockerfile bootstraps Alpine Linux with tools needed to test Vim plugins.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/vim-plugin:alpine .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --hostname alpine \
#           --name vim_plugin_alpine
#           webdavis/vim-plugin:alpine
#
# Enter container:
#
#   $ sudo docker exec -ti vim_plugin_alpine /init /bin/bash -l
#
FROM webdavis/alpine:s6
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

# Install all packages used for building and testing Vim plugins.
ADD https://bootstrap.pypa.io/get-pip.py /
RUN builddeps=' \
	    python-dev \
	    python3-dev \
	    musl-dev \
	    ' \
    && apk update --no-cache \
    && apk add --no-cache \
	    sudo \
            autoconf \
            pkgconf \
            automake \
	    make \
	    gcc \
            g++ \
	    curl \
	    git \
	    python \
	    python3 \
	    vim \
	    neovim \
            bash \
            $builddeps \
    && python2 get-pip.py \
    && python3 get-pip.py \
    && pip2 install --upgrade pip \
    && pip3 install --upgrade pip \
    && pip2 install neovim \
    && pip3 install neovim \
    && apk del --purge $builddeps \
    && rm -rf get-pip.py; \
    find / -name '*.pyc' -delete; \
    find / -name '*__pycache__*' -delete; \
    find / -type d -name '.git*' -exec rm -rf \{} \;

# Create Vim Home directory. Neovim's home directory is "~/.config/nvim" and should be
# symlinked to "~/.vim" using `docker exec` after container creation.
WORKDIR /root
RUN mkdir -- .config .vim

CMD ["/bin/bash"]
