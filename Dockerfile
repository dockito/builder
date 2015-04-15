FROM jenkins:1.585

USER root

# === installs docker ===

# Install docker client
RUN apt-get update && apt-get install -y aufs-tools ca-certificates curl git iptables xz-utils

ENV DOCKER_VERSION 1.5.0

RUN curl -SL https://get.docker.io/builds/Linux/x86_64/docker-$DOCKER_VERSION -o /usr/bin/docker \
    && chmod +x /usr/bin/docker

# Uses the docker socket shared from the host machine
ENV DOCKER_HOST unix:///tmp/docker.sock

# === installs fig.sh ===

RUN curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig

# === fixes TTY Jenkins issue ===

# Patches dockerpy to fix TTY logs
# the fix: https://github.com/d11wtq/dockerpty/pull/6
# dockerpty bug: https://github.com/d11wtq/dockerpty/issues/4
# fig bug: https://github.com/docker/fig/issues/199
RUN rm -rf /usr/local/lib/python2.7/dist-packages/dockerpty
ADD dockerpty-patch /usr/local/lib/python2.7/dist-packages/dockerpty
RUN fig --version

# === boot up jenkins ===

COPY boot.sh /boot.sh
RUN chmod +x /boot.sh

CMD ["/boot.sh"]
