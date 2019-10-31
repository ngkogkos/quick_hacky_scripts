#!/bin/bash
# Parse public S3 bucket index page and download files locally in ./s3loot folder

read_dom () {
        ORIGINAL_IFS=$IFS
        IFS=\>
        read -d \< ENTITY CONTENT
        IFS=$ORIGINAL_IFS
}

# save all in a folder called s3loot
mkdir -p s3loot

echo "Parsing $1 s3 bucket URL.."
curl -s -k "$1" | while read_dom; do
        if [[ $ENTITY = "Key" ]] ; then
                echo "Downloading: $1/$CONTENT"
                wget "$1/$CONTENT" -q -P s3loot
        fi
        done

echo "Finished.."
