# This Dockerfile bootstraps CentOS 7 with tools needed to test Vim plugins.
#
# Create image:
#
#   $ sudo docker build \
#           --force-rm \
#           --tag webdavis/vim-plugin:centos-7 .
#
# Run container:
#
#   $ sudo docker run -d -t \
#           --hostname centos \
#           --name vim_plugin_centos_7
#           webdavis/vim-plugin:centos-7
#
# Enter container:
#
#   $ sudo docker exec -ti vim_plugin_centos_7 /init /bin/bash -l
#
FROM webdavis/centos:7-s6
LABEL maintainer "Stephen A. Davis <stephen@webdavis.io>"

# Install all packages used for building and testing Vim plugins.
RUN yum update -y \
    && yum install -y \
		vim-X11 \
		make \
		git \
		sudo \
    && yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && yum install -y \
    		neovim \
		python2-neovim \
		python34-neovim \
    && yum autoremove -y; yum clean all; \
    find / -name '*.pyc' -delete; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/*

# Create Vim Home directory. Neovim's home directory is "~/.config/nvim" and should be
# symlinked to "~/.vim" using `docker exec` after container creation.
WORKDIR /root
RUN mkdir -- .config .vim

CMD ["/bin/bash"]
