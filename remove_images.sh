#!/bin/bash  

# Script to remove docker images with dependent child images
# If you try to remove the docker image and got the following message:
#     Error response from daemon: conflict: unable to delete 7045ed20ac61 (cannot be forced) - image has dependent child images
# Use this script

id=$1
if [ -z "$id"]
then
    echo "Provide image ID"
    exit 1
fi
children=$(docker inspect --format='{{.Id}}' $(docker images --filter since=$id -q))
docker rmi $children -f