#!/bin/bash
set -e

function build() {
  version=$(cat $1/blueprint.json | jq -r .version)
  name=$(cat $1/blueprint.json | jq -r .name)
  tag=ghcr.io/cownetwork/$name:$version
  exists=$(docker manifest inspect $tag > /dev/null ; echo $?)

  if [ $exists == 0 ]; then   
    echo "$tag already exists. skipping."
    return
  fi
    
  docker build -t $tag -f $1/Dockerfile $1
  docker push $tag
}

docker login ghcr.io -u $DOCKER_REG_USER -p $DOCER_REG_PASS

build base

for dir in */ ; do
  mode=$(basename $dir)
  if [ "$mode" == "base" ]; then
    continue
  fi
  build $mode
done
