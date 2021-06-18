#!/bin/bash

# Note: The working directory of this script will be always the minecraft servers root folder.
#       This simplifies many filesystem operations this script has to handle.


#{
#  "plugins": [
#    "url1",
#    "url2",
#    "url3"
#  ],
#  "maps": [
#    "url1",
#    "url2",
#    "url3"
#  ]
#}


mkdir -p plugins
cd plugins/

for plugin in $(cat ../blueprint.json | jq .plugins[] -r); do
  curl -JO $plugin
done

name=$(cat ../blueprint.json | jq .name -r) # plugin folder
mkdir -p $name/maps
cd $name/maps # plugin folder

for obj in $(cat ../../../blueprint.json | jq -c .maps[]); do
  map=$(echo "$obj" | jq .name -r)
  url=$(echo "$obj" | jq .url -r)
  echo "download $url"
  curl $url -o $map.tar.gz & # background process powaaa \(O.O)/
done

wait # wait for em to finish

count=$(find . -maxdepth 1 -type f -name "*.tar.gz" -printf x | wc -c)

if [ $count -gt 0 ]; then
  for archive in ./*.tar.gz; do
    echo "$archive"  
    tar -xzvf $archive
  done
  rm *.tar.gz
fi


ls -la

echo "move spawn to root dir"
if [ -d "spawn" ]; then 
  mv spawn ../../../spawn
fi
