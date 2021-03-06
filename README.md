# Dockerfiles

_This repo contains various Dockerfiles for images that I create._

[![Build Status](https://travis-ci.com/webdavis/dockerfiles.svg?branch=master)](https://travis-ci.com/webdavis/dockerfiles)

## Usage

The `Makefile` can build each image one by one, or all of them in parallel.

    make                       build all of the docker images, tag, and then push them to Docker Hub
    make [parent-dir/sub-dir]  run docker build on specific Dockerfiles based on the parent-dir/sub-dir provided
    make base                  run docker build on all of the baseimages
    make sub                   run docker build on everything except the baseimages (it's recommended to run make base first)
    make push                  push all repositories and their respective images to Docker Hub
    make inspect               lists all images and runs docker inspect on all images
    make cleanall              remove all Docker images on the host
    make help                  display this help menu

## About

These images can be found on [Docker Hub](https://hub.docker.com/u/webdavis).

## Extras

#### `baseimages`

The subdirectories in the `baseimages` folder contain the intermediary images that many of
the other images in this repository are built on top of. _The images under `baseimages`
should always be built first._

Furthermore, these images are based off of bare-bones operating system images, and should
only apply fixes/stability to the base operating system, which in some cases includes an
init system (yes I am aware that this is a highly contentious topic).

#### Why create this repository?

There are a number of reasons:

- **Speed**: I've been building all of my `Dockerfiles` from source, which is painfully
  slow.
- **Granularity**: I want to monitor how my images transition throughout
  [DTAP](https://en.wikipedia.org/wiki/Development,_testing,_acceptance_and_production).
- **Centralization**: If I notice trends in my build, or a tool that is mucking up my
  development environment, then most likely it will end up here.
- **Best Practices**: I want to figure out sane defaults for images within the DTAP cycle.

## Tags

See the [Tag's Wiki](https://github.com/webdavis/dockerfiles/wiki/Tags) for an in-depth
explanation.

## Logs

Check out my [worklog](./dev/worklog.md) for a play-by-play of this repo.

## Inspiration

* [Jess Frazelle's dockerfiles](https://github.com/jessfraz/dockerfiles)
   - I've seen many repos dedicated to `Dockerfiles`, but Jess's centralized proposal
     is the best solution I've seen for keeping repo-noise at a sane level.
