#!/bin/bash

IFS=',' read -r -d '' -a plugins <<< "$BUILD_PLUGINS"
mkdir -p plugins
cd plugins
for plugin in "${plugins[@]}"; do
  curl -JO $plugin
done
