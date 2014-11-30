#!/bin/bash

# signals bash to stop execution on any fail
set -e

./wrapdocker.sh

# wait for docker to start
sleep 1

if [[ $DOCKER_REGISTRY ]]; then
  docker login -u $DOCKER_REGISTRY_USER -p $DOCKER_REGISTRY_PASSWORD -e admin@bravi.com.br $DOCKER_REGISTRY
fi

/usr/local/bin/jenkins.sh
