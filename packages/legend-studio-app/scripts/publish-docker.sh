#!/bin/bash

LIGHT_BLUE='\033[1;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# NOTE: this script requires `jq` to process JSON

# NOTE: This scripts use Docker Hub V2 API. The limitation of using the `v2` API is that it is paginated,
# so we cannot get more than 10 results unlike using `v1` which gives us all tags.
# But `v1` is being deprecated and its results are not sorted, so if we do comparison, we will need to
# sort by time or interpret using `semver` which is not ideal.
# So we use `v2` API assuming that the ONLY time we release to Docker is through using this script; with
# that assumption, it's relatively safe to just check the top 10 tags.

echo -e "\n" # use echo -e to interpret the backslash escapes
echo -e "${LIGHT_BLUE}"
echo -e "###################################################################"
echo -e "#            ATTEMPTING TO PUBLISHING TO DOCKER HUB               #"
echo -e "###################################################################"
echo -e "${NC}"
echo -e "\n"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DOCKER_IMAGE_VERSION=$(cat $DIR/../package.json | jq .version | jq -r)
DOCKER_IMAGE_NAME="finos/legend-studio"

# Push Docker image
echo -e "${LIGHT_BLUE}Pushing image $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION to Docker Hub...${NC}"
docker push --quiet $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION

echo -e "\n"
echo -e "${GREEN}Successfully published image $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_VERSION to Docker Hub! ${NC}"
echo -e "\n"
