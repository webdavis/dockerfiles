# This Dockerfile bootstraps Ubuntu 18.04 LTS with tools needed to test Vim plugins.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/vim-plugin:ubuntu-18.04 .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --tmpfs /run \
#           --tmpfs /run/lock \
#           --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro \
#           --hostname ubuntu \
#           --name vim_plugin_ubuntu_18.04 \
#           webdavis/vim-plugin:ubuntu-18.04
#
# Enter container:
#
#   $ sudo docker exec -ti vim_plugin_ubuntu_18.04 /bin/bash -l
#
FROM webdavis/ubuntu:18.04-s6
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

# Install all packages used for building and testing Vim plugins.
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
		    vim \
		    make \
		    curl \
		    git \
		    sudo \
		    software-properties-common \
    && add-apt-repository -y ppa:neovim-ppa/stable \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
		    neovim \
		    python-dev \
		    python-pip \
		    python3-dev \
		    python3-pip \
    && apt-get remove -y \
		    libx11-data \
		    xauth \
		    libxmuu1 \
		    libxcb1 \
		    libxau6 \
		    libxdmcp6 \
		    multiarch-support \
    && apt-get autoremove -y; apt-get clean; \
    find / -name '*.pyc' -delete; \
    find / -name '*__pycache__*' -delete; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/*

# Create Vim Home directory. Neovim's home directory is "~/.config/nvim" and should be
# symlinked to "~/.vim" using `docker exec` after container creation.
WORKDIR /root
RUN mkdir -- .config .vim

CMD ["/bin/bash"]
