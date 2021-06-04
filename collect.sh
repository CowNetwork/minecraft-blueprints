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

cd plugins/

for plugin in $(cat $1 | jq .plugins[] -r); do
  curl -JO $plugin
done

cd $(cat $1 | jq .name -r)/maps # plugin folder

for obj in $(cat $1 | jq -c .maps[]); do
  map=$(echo "$obj" | jq .name -r)
  url=$(echo "$obj" | jq .url -r)
  echo "download $url"
  curl $url -s -o $map.tar.gz & # background process powaaa \(O.O)/
done

wait # wait for em to finish

for archive in ./*.tar.gz; do
  echo "$archive"  
  tar -xzvf $archive
done

rm *.tar.gz

echo "move spawn to root dir"
mv spawn ../../../spawn




