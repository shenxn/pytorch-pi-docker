#!/bin/bash

set -ex

DOCKER_TAG=shenxn/pytorch-pi

# Docker login
docker login

# Read version
RELEASE=`cat VERSION`

# Docker build and push
docker buildx build \
    --platform linux/arm/v7 \
    --build-arg ARG_VERSION=${RELEASE} \
    --tag ${DOCKER_TAG}:latest --tag ${DOCKER_TAG}:${RELEASE} \
    --push .
