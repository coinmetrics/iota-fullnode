#!/bin/sh

set -e

export VERSION=$(cat version.txt)
echo "Image version ${VERSION}."

echo "Building IOTA image..."
docker build --build-arg "VERSION=${VERSION}" -t "${DOCKER_REGISTRY_REPO}:${VERSION}" .
echo "IOTA image ready."

echo "Building Nelson image..."
docker build --build-arg "VERSION=${VERSION}" -t "${DOCKER_REGISTRY_REPO}:nelson-${VERSION}" -f Dockerfile-nelson .
echo "Nelson image ready."

if [ -n "${DOCKER_REGISTRY}" ] && [ -n "${DOCKER_REGISTRY_USER}" ] && [ -n "${DOCKER_REGISTRY_PASSWORD}" ]
then
	echo "Logging into ${DOCKER_REGISTRY}..."
	docker login -u="${DOCKER_REGISTRY_USER}" -p="${DOCKER_REGISTRY_PASSWORD}" "${DOCKER_REGISTRY}"
	echo "Pushing IOTA image to ${DOCKER_REGISTRY_REPO}:${VERSION}..."
	docker push "${DOCKER_REGISTRY_REPO}:${VERSION}"
	echo "Pushing Nelson image to ${DOCKER_REGISTRY_REPO}:nelson-${VERSION}..."
	docker push "${DOCKER_REGISTRY_REPO}:nelson-${VERSION}"
fi
