# Worklog

_This file tracks progress on the Dockerfiles project._

## Why this file exists ...

I'm using this file as an electronic bookmark, so to speak. Logging this stuff in commits
makes them bloated, and ends up causing odd work-in-progress commits, which is bad
practice.

This file should always be committed by itself to prevent any strange merge problems. To
ignore TravisCI builds insert the text `[skip travisci]` in the header of the Git commit,
like so:

```
[skip travisci] ... some commit message ...
```

## Logs

### 2019-03-05, Tuesday

- 1:00h (0600-0700): Copied Arch Linux `Dockerfile` into `baseimages` and refactored it.

### 2019-03-07, Thursday

- 0:30m (0600-0630): Need a better init system than `systemd`; started searching around
  for available options. Read through https://github.com/just-containers/s6-overlay and
  decided to fork baseimages into two separate PID 1 processes: `systemd` and `s6`.
  `systemd` baseimages are useful for things like Ansible Roles because some services make
  use of it. `s6` is useful for everything else. It has built in support for dropping
  privileges (great for production containers), and can be configured to kill the
  container for failed processes, which adheres to the "Docker way".
- 2:00h (2310-0110): Read through the following resources to wrap my head around
  [s6](http://skarnet.org/software/s6/index.html) (`s6`):
  - http://skarnet.org/software/s6/overview.html
  - http://skarnet.org/software/s6/why.html
  - http://smarden.org/runit/
  - http://skarnet.org/software/s6/s6-svscan-1.html
  - http://skarnet.org/software/s6/notifywhenup.html
  - https://jdebp.eu/FGA/unix-daemon-design-mistakes-to-avoid.html
  - https://tutumcloud.wordpress.com/2014/12/02/docker-and-s6-my-new-favorite-process-supervisor/
  - http://skarnet.org/software/execline/

### 2019-03-15, Friday

- 0:10m (1530-1540): Read through [Docker and S6 - My New Favorite Process
  Supervisor](https://tutumcloud.wordpress.com/2014/12/02/docker-and-s6-my-new-favorite-process-supervisor/)
  again as a refresher.
- 0:12m (1540-1552): Read [S6 Made Easy, with the S6
  Overlay](https://tutumcloud.wordpress.com/2015/05/20/s6-made-easy-with-the-s6-overlay/)
- 1:00h (1717-1817): Read [`execline`
  documentation](http://skarnet.org/software/execline/) and wrote some sample scripts.
- 2:10h (2100-2310) Read about running dnsmasq in Docker containers. Note this
  [issue](https://github.com/moby/moby/issues/23910#issuecomment-247964052) on moby. I
  don't feel comfortable to integrate this yet. I'll have to take a closer look later on.
- 0:30m (2330-0000) Randomly stumbled on [Goss](https://github.com/aelsabbahy/goss) and
  read through some of the attached pages in the link.

### 2019-03-16, Saturday

- 0:10m (2000-2110): Read [Run multiple services in a
  container](https://docs.docker.com/config/containers/multi-service_container/).
- 0:10m (2110-2115): Created intermediary containers without heavyweight init system.


### 2019-03-17, Sunday

- 1:30h (1600-1730): Refactored and individually tested each image.
- 0:30m (1730-1800): Created `webdavis/vim-plugin:alpine` and set as default vim-plugin
  image.

### 2019-03-18, Monday

- 0:05m (1545-1600): Thought about adding a clean target to the `Makefile` for individual
  docker images but decided that it's just not worth the trouble.
- 1:00h (1700-1800): Test out TravisCI builds.
- 2:00h (2000-2227): Ran TravisCI builds repeatedly, making alterations to the Travis
  environment, until all builds passed. Implemented YAML aliases to reduce duplication;
  see: https://docs.travis-ci.com/user/build-stages/using-yaml-aliases/

### 2019-03-19, Tuesday

- 0:25m (1000-1100): Created Grip image.
  - This didn't work exactly like I though it would. The port mapping needs to be declared
    twice: once from `host:container`, and again as an argument to grip as
    `container:localhost`.

### 2019-03-20, Wednesday

- 1:00h (0800-0900): Issue #4: Tags Wiki creation.
  - Decided to go with an example, walking the imaginary person through creating a repo
  with a dynamically generated tag.

### 2019-03-22, Friday

- 1:00h (1000-1100): Added some packages to build ctags in `vim-plugin:alpine`

### 2019-03-25, Monday

- 1:40m (0800-0940): Read about Gerrit, a Git code review tool. I would like to have an
  image of this because I'll most likely have to run multiple servers.
