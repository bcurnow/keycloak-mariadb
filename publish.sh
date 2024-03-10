#!/bin/bash

readonly IMAGE_NAME=keycloak-mariadb
readonly REGISTRY=registry.internal.curnowtopia.com

version=$1
if [ -z ${version} ]
then
  echo "You must provide the version number" >&2
  exit 1
fi

currentDir=$(dirname $0)
currentDir=$(cd ${currentDir} && pwd)

# Build the docker image
echo "Building the '${IMAGE_NAME}:${version}'..."
docker build --build-arg="KC_VERSION=${version}" --tag ${REGISTRY}/${IMAGE_NAME}:${version} ${currentDir}

if [ $? -ne 0 ]
then
  echo "Failed!"
  exit 1
fi

# Publish to the registry
docker push ${REGISTRY}/${IMAGE_NAME}:${version}
