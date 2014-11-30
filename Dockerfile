FROM jenkins:1.585

USER root

# force full apt-get update
RUN rm -rf /var/lib/apt/lists/ && apt-get -q -y update

# === installs docker ===

RUN apt-get install -y apt-transport-https

ENV DEBIAN_FRONTEND noninteractive
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
RUN apt-get -q -y update
RUN apt-get -q -y install lxc-docker-1.2.0
RUN echo 'DOCKER_OPTS="-H :2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
VOLUME /var/lib/docker
EXPOSE 2375

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

COPY wrapdocker.sh /wrapdocker.sh
RUN chmod +x /wrapdocker.sh

COPY boot.sh /boot.sh
RUN chmod +x /boot.sh

CMD ["/boot.sh"]
