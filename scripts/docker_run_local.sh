#!/bin/bash

sudo docker rmi --force keypr:local

sudo docker container prune --force

sudo docker build . --tag keypr:local --no-cache --progress plain

sudo docker run --detach --name keypr keypr:local

sudo docker images --all --format '{{.Size}}' keypr:local
