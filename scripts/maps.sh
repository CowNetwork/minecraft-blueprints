#!/bin/bash
set -e

mkdir -p plugins/$BUILD_BLUEPRINT_NAME/maps
cd plugins/$BUILD_BLUEPRINT_NAME/maps # plugin folder

for obj in $(echo "$BUILD_MAPS" | jq -c .[]); do
  map=$(echo "$obj" | jq .name -r)
  url=$(echo "$obj" | jq .url -r)
  echo "download $url"
  curl $url -o $map.tar.gz & # background process powaaa \(O.O)/
done

wait # wait for em to finish

count=$(find . -maxdepth 1 -type f -name "*.tar.gz" -printf x | wc -c)

if [ $count -gt 0 ]; then
  for archive in *.tar.gz; do
    echo "$archive"
    tar -xzvf $archive
  done
  rm *.tar.gz
fi

echo "move spawn to root dir"
if [ -d "spawn" ]; then
  mv spawn ../../../spawn
fi



