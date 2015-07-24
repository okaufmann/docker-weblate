#!/bin/sh

docker-compose stop

docker-compose rm --force

#remove all images
#docker rmi $(docker images -q)

#remove all containers
#docker rm $(docker ps -a -q)

#clear directories
sudo rm -Rf var/lib/weblate/*
sudo rm -Rf var/lib/git/*
sudo rm -Rf var/lib/mysql/*

docker build --no-cache --tag="okaufmann/weblate-docker:latest" ../../build/weblate

docker-compose up

exit 0