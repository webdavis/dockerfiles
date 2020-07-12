#
# This makefile has the following targets:
#
# - make                       build all of the docker images, tag, and then push them to Docker Hub
# - make [parent-dir/sub-dir]  run docker build on specific Dockerfiles based on the parent-dir/sub-dir provided
# - make base                  run docker build on all of the baseimages
# - make sub                   run docker build on everything except the baseimages (it's recommended to run `make base` first)
# - make push                  push all repositories and their respective images to Docker Hub
# - make inspect               lists all images and runs docker inspect on all images
# - make cleanall              remove all Docker images on the host
# - make help                  display this help menu
#

# Constants.
docker := sudo docker
profile := webdavis
baseimages_dir := baseimages

default: all

define namespace
	$(eval name := $(dir $(1)))
	$(eval name := $(notdir $(name:/=)))
	$(eval repo := ${profile}/${name})
	$(eval tag := $(notdir $(1)))
	$(eval img := ${repo}:${tag})
endef

# Contains the variable LATEST.
include Make_latest.mak

define build
	$(call namespace,$(1))
	@${docker} build --no-cache --force-rm --tag ${img} $(1)
	$(if $(wildcard $(CURDIR)/$(1)/tag),${docker} tag ${img} ${repo}:`$(file < $(CURDIR)/$(1)/tag)`)
	$(if $(filter ${name}:${tag},${LATEST}),${docker} tag ${img} ${repo}:latest)
endef

# Any image under the baseimages/ directory.
BASEIMAGES := $(sort $(shell find -L $(baseimages_dir)/* -iname '*Dockerfile' -type f))
BASEIMAGES := $(dir ${BASEIMAGES})
BASEIMAGES := ${BASEIMAGES:baseimages/%/=%}

base: $(BASEIMAGES)

.ONESHELL:
$(BASEIMAGES):
	@:$(call build,baseimages/$(@))

# Any image NOT under the baseimages/ directory.
SUBIMAGES := $(sort $(shell find -L . -iname '*Dockerfile' -type f | grep -v '${baseimages_dir}'))
SUBIMAGES := $(dir ${SUBIMAGES})
SUBIMAGES := ${SUBIMAGES:/=}

sub: $(SUBIMAGES)

.ONESHELL:
$(SUBIMAGES):
	@:$(call build,$(@))

# Make a list of the repositories names.
REPOS := $(shell find -L . -iname '*Dockerfile' -type f)
REPOS := $(dir $(REPOS:/=))
REPOS := $(dir $(REPOS:/=))
REPOS := $(addprefix ${profile}/,$(sort $(notdir $(REPOS:/=))))

push: $(REPOS)

$(REPOS):
	@${docker} push $(@)

# This Makefile shouldn't create any files.
.PHONY: all base $(BASEIMAGES) sub $(SUBIMAGES) push $(REPOS)

all: base sub push

inspect:
	@${docker} image ls -a
	@${docker} inspect $(shell ${docker} image ls -q)

# Be careful! This removes all of the Docker images on the host.
cleanall:
	@${docker} rmi -f $(shell ${docker} image ls -q)

help:
	@echo
	@echo "make                       run the Vim tests inside of Vim and Neovim, inside of a Docker container"
	@echo "make [parent-dir/sub-dir]  run docker build on the Dockerfile in the parent-dir/sub-dir"
	@echo "make cleanall              remove all Docker images on the host"
	@echo "make help                  display this help menu"
	@echo
	@echo "Available Baseimages:"
	@echo ${BASEIMAGES} | sed -e 's/ /\n- /g' -e 's/^/- /g'
	@echo
	@echo "Available Subimages:"
	@echo ${SUBIMAGES} | sed -e 's/\.\///g' -e 's/ /\n- /g' -e 's/^/- /g'
