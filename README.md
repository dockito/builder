# Dockito Builder

Docker Image to with [Jenkins](http://jenkins-ci.org/), [fig.yml](http://fig.sh/) and [Docker](http://docker.io/).

## Usage

```bash
docker run -p 8080:8080 --privileged -v /your/home:/var/jenkins_home dockito/builder
```

## Configuration

To authenticate in a private Docker registry:

- `DOCKER_REGISTRY_USER`: admin
- `DOCKER_REGISTRY_PASSWORD`: 123
- `DOCKER_REGISTRY`: https://docker.dockito.com.br/v1/

## Recommended plugins

* [AnsiColor Plugin](https://wiki.jenkins-ci.org/display/JENKINS/AnsiColor+Plugin);
* [Git Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin);
* [Managed Scripts](https://wiki.jenkins-ci.org/display/JENKINS/Managed+Script+Plugin).

## Known issues

* There is a issue with TTY, Docker and Jenkins that has been temporarily fixed with a patch, see Jenkin's Dockerfile for more information;
* Volumes are not working properly inside the Jenkins container while running `fig` tasks. So it is advisable to not map volumes on fig environments used for test execution.

## Acknowledgments

* [Jenkins Image](https://github.com/cloudbees/jenkins-ci.org-docker);
* [Docker in Docker (Dind)](https://github.com/jpetazzo/dind).
