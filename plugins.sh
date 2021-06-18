#!/bin/bash

IFS=',' read -r -d '' -a plugins <<< "$BUILD_PLUGINS"
cd plugins
for plugin in "${plugins[@]}"; do
  curl -JO $plugin
done
