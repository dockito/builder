FROM jenkins:1.642.2

USER root

# === installs docker ===

# Install docker client
RUN apt-get update && apt-get install -y aufs-tools ca-certificates curl git iptables xz-utils

ENV DOCKER_VERSION 1.8.3

RUN curl -SL https://get.docker.io/builds/Linux/x86_64/docker-$DOCKER_VERSION -o /usr/bin/docker \
    && chmod +x /usr/bin/docker

# Uses the docker socket shared from the host machine
ENV DOCKER_HOST unix:///tmp/docker.sock

# === installs fig.sh ===

RUN curl -L https://github.com/docker/fig/releases/download/1.0.1/fig-`uname -s`-`uname -m` > /usr/local/bin/fig; chmod +x /usr/local/bin/fig
RUN curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose

# === boot up jenkins ===

COPY boot.sh /boot.sh
RUN chmod +x /boot.sh

CMD ["/boot.sh"]
