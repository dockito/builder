# Dockito Builder

Docker Image to with [Jenkins](http://jenkins-ci.org/) and [docker-compose](https://github.com/docker/compose).

It uses the host's Docker daemon to start containers to run the builds/tests.

## Usage

```bash
docker run -p 8080:8080 -v /your/home:/var/jenkins_home -v /var/run/docker.sock:/tmp/docker.sock dockito/builder
```

## Recommended plugins

* [AnsiColor Plugin](https://wiki.jenkins-ci.org/display/JENKINS/AnsiColor+Plugin);
* [Git Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Git+Plugin);
* [Managed Scripts](https://wiki.jenkins-ci.org/display/JENKINS/Managed+Script+Plugin);
* [Multi-Branch Project Plugin](https://github.com/mjdetullio/multi-branch-project-plugin).

## Known issues

* There is a issue with TTY, Docker and Jenkins that has been temporarily fixed with a patch, see Jenkin's Dockerfile for more information;
* Volumes are not working properly inside the Jenkins container while running `fig` tasks. So it is advisable to not map volumes on fig environments used for test execution.

## Acknowledgments

* [Jenkins Image](https://github.com/cloudbees/jenkins-ci.org-docker);
