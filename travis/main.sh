#!/usr/bin/env sh

# Installs make-4.2 which is needed to use make's file function.
wget http://ftp.gnu.org/gnu/make/make-4.2.tar.gz
tar xvf make-4.2.tar.gz
cd make-4.2
./configure
make
sudo make install
