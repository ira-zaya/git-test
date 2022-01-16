#!/bin/bash

# set username and password
UNAME="bohdan1993"
UPASS=`cat /home/ubuntu/dockerhub/pass.txt`

# get token to be able to talk to Docker Hub
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${UNAME}'", "password": "'${UPASS}'"}' https://hub.docker.com/v2/users/login/ | jq -r .token)
# get list of repos for that user account
REPO_LIST=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/?page_size=10000 | jq -r '.results|.[]|.name')

for i in ${REPO_LIST}
do
# get tags of images and delete last 2 tags from variable
    IMAGE_TAGS=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/${i}/tags/?page_size=10000 | jq -r '.results|.[]|.name')
    IMAGE_TAGS=`echo ${IMAGE_TAGS} | awk '{$1=""; $2=""; print $0}' | cut -c 2-`
    for j in ${IMAGE_TAGS}
	do
	curl -s  -X DELETE  -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2/repositories/${UNAME}/${i}/tags/${j}/
	done
done
